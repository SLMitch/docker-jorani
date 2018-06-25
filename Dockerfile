FROM php:7-apache

RUN apt-get update && apt-get install -y wget bsdtar \
	  && rm -rf /var/cache/apt

# Install opcache 
RUN docker-php-ext-install opcache pdo_mysql

ENV VERSION_JORANI 0.6.5

WORKDIR /var/www/html/

RUN wget "https://github.com/bbalet/jorani/releases/download/v${VERSION_JORANI}/jorani-${VERSION_JORANI}.zip" -O - | bsdtar --exclude=.git -xvf- \
	&& mv jorani/* jorani/.ht* jorani/.git* .  && rmdir jorani
RUN chown -R www-data .
