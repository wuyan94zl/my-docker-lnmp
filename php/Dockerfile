FROM php:7.3-fpm

COPY sources.list /etc/apt/sources.list
ADD phpredis-5.2.2.tar.gz /usr/local/src

# 安装依赖
RUN apt-get clean && apt-get update && apt-get install -y \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
	libzip-dev \
	libmemcached-dev \
	zlib1g-dev \
	libcurl4-openssl-dev \
	libxml2-dev \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

# 安装php扩展
RUN docker-php-source extract \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install pcntl \
&& docker-php-ext-install gd \
&& docker-php-ext-install zip \
&& mv /usr/local/src/phpredis-5.2.2 /usr/src/php/ext/redis \
&& docker-php-ext-install redis

# 安装cron定时任务 和 supervisor 进程管理
RUN apt-get update && apt-get install -y cron \
&& apt-get install -y supervisor

COPY supervisor /etc/supervisor/conf.d
COPY entrypoint.sh /entrypoint.sh
COPY test.sh /var/www/test.sh
COPY crontabs /var/spool/cron/crontabs

RUN chmod +x /entrypoint.sh \
&& chmod +x /var/www/test.sh \
&& crontab /var/spool/cron/crontabs/www-data

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm", "-F"]