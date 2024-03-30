FROM php:8.2-fpm-alpine

RUN apk --update add wget \
  curl \
  git \
  grep \
  build-base \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  imagemagick-dev \
  pcre-dev \
  libtool \
  make \
  autoconf \
  g++ \
  cyrus-sasl-dev \
  libgsasl-dev \
  supervisor

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN docker-php-ext-install mysqli pdo pdo_mysql xml
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

RUN rm /var/cache/apk/*

WORKDIR /var/www
# COPY . /var/www
# RUN composer i

COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]


# updated dockerfile for task requirement #

# Use the PHP 8.2 FPM Alpine base image
FROM php:8.2-fpm-alpine

# Install necessary packages and extensions
RUN apk --update add wget \
    curl \
    git \
    grep \
    build-base \
    libmemcached-dev \
    libmcrypt-dev \
    libxml2-dev \
    imagemagick-dev \
    pcre-dev \
    libtool \
    make \
    autoconf \
    g++ \
    cyrus-sasl-dev \
    libgsasl-dev \
    supervisor

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql xml
RUN pecl channel-update pecl.php.net \
    && pecl install memcached \
    && pecl install imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable imagick

# Clean up
RUN rm /var/cache/apk/*

# Set the working directory
WORKDIR /var/www

# Copy the supervisord configuration file
COPY ./dev/docker-compose/php/supervisord-app.conf /etc/supervisord.conf

# Use CMD instead of ENTRYPOINT for Kubernetes
CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
