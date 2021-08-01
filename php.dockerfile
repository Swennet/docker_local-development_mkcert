FROM php:8.0-fpm-alpine


# Add configuration file for php-fpm
ADD ./php/www.conf /usr/local/etc/php-fpm.d/

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add user/usergroup
RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

# Create directories and apply permissions
RUN mkdir -p /var/www/html
RUN mkdir -p /home/laravel/.composer

RUN chown -R laravel:laravel /home/laravel
RUN chown -R laravel:laravel /var/www/html

# Assign Workdirectory
WORKDIR /var/www/html

# Install additional extentions for mysql
RUN docker-php-ext-install pdo pdo_mysql

# Assign User
USER laravel
