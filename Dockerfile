FROM php:7-apache

RUN apt-get update && apt-get install -y wget bsdtar \
	  && rm -rf /var/cache/apt

RUN apt-get update && apt-get install -y wget \
  	libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev  libldap2-dev libxml2-dev  && rm -rf /var/cache/apt

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd ldap xml opcache pdo_mysql zip


RUN a2enmod rewrite

ENV VERSION_JORANI 0.6.5

WORKDIR /var/www/html/

RUN wget "https://github.com/bbalet/jorani/releases/download/v${VERSION_JORANI}/jorani-${VERSION_JORANI}.zip" -O - | bsdtar --exclude=.git -xvf- \
	&& mv jorani/* jorani/.ht* jorani/.git* .  && rmdir jorani
RUN chown -R www-data .
