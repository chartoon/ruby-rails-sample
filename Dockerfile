FROM ruby:2.2-alpine
MAINTAINER charuhas.mehendale@xoriant.com

RUN apk update && apk add libstdc++ tzdata postgresql-client nodejs

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN gem install foreman

RUN apk --update add --virtual build-dependencies build-base ruby-dev \  
    postgresql-dev libc-dev linux-headers && \
    cd /app ; bundle install --without development test && \
    apk del build-dependencies

ADD . /app/  
RUN chown -R nobody:nogroup /app  
USER nobody

ENV RAILS_ENV production  
WORKDIR /app

EXPOSE 80
#CMD ["bundle", "exec", "unicorn", "-p", "8080", "-c", "./config/unicorn.rb"]

RUN cd /app ; bundle exec rake bootstrap
CMD ["/usr/local/bundle/bin/foreman" "-p" "8080" "start"]
