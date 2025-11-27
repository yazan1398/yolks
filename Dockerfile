FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git unzip curl libpng-dev libzip-dev libonig-dev libxml2-dev zip nginx \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd bcmath

WORKDIR /var/www/html

COPY . .

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN composer install --no-dev --optimize-autoloader

RUN cp .env.example .env
RUN php artisan key:generate

CMD php artisan serve --host=0.0.0.0 --port=10000
