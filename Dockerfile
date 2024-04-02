FROM ruby:3.3-bookworm

RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /app

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

CMD ["rails", "server", "-b", "0.0.0.0"]