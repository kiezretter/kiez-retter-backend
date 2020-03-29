FROM ruby:2.7.0 AS dev

ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y nodejs yarn \
 && rm /var/lib/apt/lists/* -fR

RUN gem install --no-document bundler

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install -j4

COPY package.json yarn.lock ./
RUN yarn install

CMD ["rails", "server", "-b", "0.0.0.0"]
EXPOSE 3000/tcp

# prod
FROM dev AS prod

ENV RAILS_ENV production
COPY . .
ARG RAILS_MASTER_KEY
RUN bundle exec rake assets:precompile

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
