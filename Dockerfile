FROM php:7.0.9-fpm

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
	&& git clone --depth=1 git://github.com/phalcon/cphalcon.git \
	&& cd cphalcon/build \
	&& ./install \ 
	&& rm -rf ../../cphalcon

CMD ["php-fpm"]
