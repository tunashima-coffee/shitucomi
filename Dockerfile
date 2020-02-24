FROM ruby:2.7.0

# ENV TZ=Asia/Tokyo

# RUN \
#     apt-get update && \
#     apt-get install -y \
#     git \
#     default-mysql-client
#
# WORKDIR /api-rails
#
# COPY ./Gemfile /api-rails
# COPY ./Gemfile.lock /api-rails
# RUN bundle install --path vendor/bundle -j4
#
# COPY . /api-rails


# ARG USERNAME
# ARG ACCESS_TOKEN

# ENV BUNDLE_GITHUB__COM=$USERNAME:$ACCESS_TOKEN

WORKDIR /shitsucomi
ADD Gemfile /shitsucomi/Gemfile
ADD Gemfile.lock /shitsucomi/Gemfile.lock

RUN set -x && \
    apt-get -qq update && \
    apt-get -qq upgrade -y && \
    apt-get -qq install -y build-essential && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get -qq update && apt-get -y install yarn && \
    yarn install && \
    bundle install && \
    bundle exec rails webpacker:install

COPY . /shitsucomi

# CMD ["rails", "server", "-b", "0.0.0.0"]
