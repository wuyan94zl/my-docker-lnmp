FROM php:7.3-fpm

ENV DEBIAN_FRONTEND noninteractive

# 更改 apt-get 源为阿里云
COPY sources.list /etc/apt/sources.list

# 添加 phpredis 扩展文件 到 容器
ADD phpredis-5.2.2.tar.gz /usr/local/src

# 安装依赖
RUN apt-get clean && apt-get update && apt-get install -y \
	apt-utils \
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

# 安装php常用扩展
RUN docker-php-source extract \
&& docker-php-ext-install mysqli \
&& docker-php-ext-install pdo_mysql \
&& docker-php-ext-install pcntl \
&& docker-php-ext-install gd \
&& docker-php-ext-install zip \

# 安装phpredis扩展
&& mv /usr/local/src/phpredis-5.2.2 /usr/src/php/ext/redis \
&& docker-php-ext-install redis

# 安装cron定时任务 和 supervisor 进程管理
RUN apt-get update && apt-get install -y cron \
&& apt-get install -y supervisor

# 添加配置 supervisor 
COPY supervisor /etc/supervisor/conf.d
# 添加定时任务配置 crontabs
COPY crontabs /var/spool/cron/crontabs

# 添加 启动shell脚本
COPY entrypoint.sh /entrypoint.sh

# 设置脚本为可执行
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm", "-F"]