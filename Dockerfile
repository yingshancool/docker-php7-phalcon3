FROM php:7.0.9-fpm

MAINTAINER technofiend <2281551151@qq.com>

RUN set -ex \
	&& mv /etc/apt/sources.list /etc/apt/sources.list.bak \
	&& { \
		echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib"; \
		echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib"; \
		echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib"; \
		echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib"; \
	} | tee /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y git libpcre3-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
	&& docker-php-ext-install -j$(nproc) iconv mcrypt \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install -j$(nproc) gd \
	&& docker-php-ext-install pdo_mysql \ 
	&& curl -o /usr/local/etc/php/php.ini https://raw.githubusercontent.com/php/php-src/PHP-7.0.9/php.ini-production \
	&& git clone --depth=1 git://github.com/phalcon/cphalcon.git \
	&& cd cphalcon/build \
	&& ./install \ 
	&& rm -rf ../../cphalcon \ 
	&& docker-php-ext-enable phalcon

CMD ["php-fpm"]
