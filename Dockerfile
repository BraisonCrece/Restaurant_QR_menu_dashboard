# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.2
FROM ruby:$RUBY_VERSION-slim as base

LABEL fly_launch_runtime="rails"

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT="1"

# Update gems and bundler
RUN gem update --system --no-document && \
    gem install -N bundler

# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems and libvips dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev pkg-config libglib2.0-dev libexpat1-dev \
    wget \
    tar \
    libgirepository1.0-dev \
    libjpeg-dev \
    libpng-dev \
    && wget https://github.com/libvips/libvips/archive/refs/tags/v8.14.2.tar.gz \
    && tar xvzf v8.14.2.tar.gz \
    && cd libvips-8.14.2 \
    && apt-get install -y meson ninja-build \
    && meson setup build --prefix /usr/local \
    && cd build \
    && ninja \
    && ninja install

# Install application gems
COPY --link Gemfile Gemfile.lock ./
RUN bundle install && \
    bundle exec bootsnap precompile --gemfile && \
    rm -rf ~/.bundle/ $BUNDLE_PATH/ruby/*/cache $BUNDLE_PATH/ruby/*/bundler/gems/*/.git

# Copy application code
COPY --link . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE=DUMMY ./bin/rails assets:precompile

# Final stage for app image
FROM base

# Install packages needed for deployment and libvips dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libsqlite3-0 postgresql-client libglib2.0-0 libexpat1 libjpeg62-turbo libpng16-16 \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy vips libraries from build stage
COPY --from=build /usr/local/lib /usr/local/lib
COPY --from=build /usr/local/share /usr/local/share
RUN ldconfig

# Run and own the application files as a non-root user for security
RUN useradd rails --home /rails --shell /bin/bash
USER rails:rails

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build --chown=rails:rails /rails /rails

# Deployment options
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true"

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
