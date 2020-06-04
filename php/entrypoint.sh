#!/bin/sh

/usr/bin/supervisord -c "/etc/supervisor/supervisord.conf"
/etc/init.d/cron start

exec "$@"
