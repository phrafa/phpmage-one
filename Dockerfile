FROM php:5.6-fpm

RUN apt-get -y update

# MCRYPT
RUN apt-get install -y libmcrypt-dev
RUN docker-php-ext-install mcrypt

# BCMATH
RUN docker-php-ext-install bcmath && docker-php-ext-enable bcmath

#SOAP
RUN apt-get install -y libxml2-dev && \
    docker-php-ext-install soap

# MYSQL
RUN docker-php-ext-install pdo pdo_mysql mysql

# ZIP
RUN apt-get install -y zlib1g-dev zip && docker-php-ext-install zip

# GD
RUN apt-get update -y && apt-get install -y sendmail libpng-dev
RUN docker-php-ext-install gd

# XDEBUG
RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

# GIT
RUN apt-get install git -y

COPY ./php.ini /usr/local/etc/php/conf.d/custom.ini

# COMPOSER
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

# COMPASS
RUN apt-get install -y ruby-compass

# LOCALE
RUN apt-get install -y locales
RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
