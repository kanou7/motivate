FROM ruby:2.6.5
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    nodejs \
    yarn
WORKDIR /motivate
COPY Gemfile Gemfile.lock /motivate/
RUN gem install bundler
RUN bundle install
ADD . /motivate
