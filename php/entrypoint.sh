#!/bin/sh

# 启动 supervisord 进程管理
/usr/bin/supervisord -c "/etc/supervisor/supervisord.conf"

# 加载并启动 cron 定时任务
/etc/init.d/cron reload
/etc/init.d/cron start

# 设置定时任务配置文件，如没有设置，定时任务不会执行，且 php/crontabs 文件夹下有哪些文件都需要设置
# crontab /var/spool/cron/crontabs/root
crontab /var/spool/cron/crontabs/www-data

# ENTRYPOINT shell 脚本固定语句
exec "$@"
