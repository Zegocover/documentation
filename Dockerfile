FROM ruby:2.3.7-stretch

RUN apt-get update && \
    apt-get install -y curl software-properties-common && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

WORKDIR /docs

COPY . /docs

RUN gem install bundler && \
    bundle install

CMD ["bundle", "exec", "middleman", "server"]
