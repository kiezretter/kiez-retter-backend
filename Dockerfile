FROM ruby:2.6.5

RUN apt-get update \
 && apt-get -y install nodejs npm \
 && rm /var/lib/apt/lists/* -fR

RUN npm install -g yarn
RUN gem install --no-document bundler

WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
