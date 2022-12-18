FROM ruby:2.7.5

RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \
                       nodejs \
                       default-mysql-client \
                       yarn

WORKDIR /portfolio_3

COPY Gemfile /portfolio_3/Gemfile
COPY Gemfile.lock /portfolio_3/Gemfile.lock

RUN bundle install
ADD . /portfolio_3
