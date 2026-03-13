FROM php:8.4-fpm

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN chown -R www-data:www-data /var/www

RUN adduser --disabled-password --gecos '' developer \
    && chown -R developer:www-data /var/www \
    && chmod 755 /var/www

RUN mkdir -p /var/www/html/node_modules \
    && chown -R developer:www-data /var/www/html/node_modules

USER developer