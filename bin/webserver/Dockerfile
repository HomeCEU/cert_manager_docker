FROM php:7.3-apache-stretch 

# Surpresses debconf complaints of trying to install apt packages interactively
ARG DEBIAN_FRONTEND=noninteractive

# Update
RUN apt-get -y update --fix-missing && \
    apt-get upgrade -y && \
    apt-get --no-install-recommends install -y apt-utils && \
    rm -rf /var/lib/apt/lists/*

# Install xdebug
RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

# Install PDO Mysql
RUN docker-php-ext-install pdo_mysql

RUN a2enmod rewrite headers

RUN rm -rf /usr/src/*

RUN php -v && \
    php -m
