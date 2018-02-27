FROM ruby:2.2-alpine
MAINTAINER charuhas.mehendale@xoriant.com

RUN apk update && apk add libstdc++ tzdata postgresql-client nodejs

ADD Gemfile /app/  
ADD Gemfile.lock /app/

#RUN gem install foreman nokogiri:1.6.6.2
#RUN gem install nokogiri -v '1.6.6.2'

#RUN apk --update add --virtual build-dependencies build-base ruby-dev \  
RUN apk --update add --virtual build-dependencies build-base \  
    postgresql-dev libc-dev linux-headers libxml2 libxml2-dev libxslt libxslt-dev ruby-libs &&  \
    bundle config build.nokogiri --use-system-libraries && \
    cd /app ; bundle install --without development test
#    cd /app ; bundle install --without development test && \
#    apk del build-dependencies

RUN gem install foreman

ADD . /app/  
RUN chown -R nobody:nogroup /app  
USER nobody

ENV RAILS_ENV production  
WORKDIR /app

EXPOSE 3000
#CMD ["bundle", "exec", "unicorn", "-p", "8080", "-c", "./config/unicorn.rb"]

#RUN cd /app ; bundle exec rake bootstrap
#CMD ["foreman" "-p" "8080" "start"]
CMD ["/usr/local/bundle/bin/foreman","start","-f","./Procfile"]
