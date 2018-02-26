FROM ruby:2.1-alpine
MAINTAINER charuhas.mehendale@xoriant.com

RUN apk update && apk add libstdc++ tzdata postgresql-client nodejs

ADD ruby-rails-sample/Gemfile /app/  
ADD ruby-rails-sample/Gemfile.lock /app/

RUN gem install foreman

RUN apk --update add --virtual build-dependencies build-base ruby-dev \  
    postgresql-dev libc-dev linux-headers && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD ruby-rails-sample/* /app/  
RUN chown -R nobody:nogroup /app  
USER nobody

ENV RAILS_ENV production  
WORKDIR /app

EXPOSE 80
#CMD ["bundle", "exec", "unicorn", "-p", "8080", "-c", "./config/unicorn.rb"]

RUN cd /app ; bundle exec rake bootstrap
CMD ["/usr/local/bundle/bin/foreman" "-p" "8080" "start"]
