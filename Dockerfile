FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs
WORKDIR /motivate
COPY Gemfile Gemfile.lock /motivate/
RUN gem install bundler
RUN bundle install
ADD . /motivate