# --- Stage 1 : build des assets front (Vite) ---
FROM node:20-alpine AS frontend
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# --- Stage 2 : dépendances PHP (Composer) ---
FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --ignore-platform-reqs
COPY . .
RUN composer dump-autoload --optimize --no-dev

# --- Stage 3 : image finale PHP-FPM ---
FROM php:8.1-fpm-alpine

RUN apk add --no-cache \
        libpng-dev libjpeg-turbo-dev freetype-dev \
        libzip-dev zip unzip icu-dev oniguruma-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

WORKDIR /var/www/html

COPY --from=vendor /app /var/www/html
COPY --from=frontend /app/public/build /var/www/html/public/build

RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
