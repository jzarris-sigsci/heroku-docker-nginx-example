#!/bin/sh
/bin/bash -c "envsubst '\$PORT' < /etc/nginx/sites-enabled/default.conf > /etc/nginx/sites-enabled/default.conf" && nginx -g 'daemon off;' &
/usr/sbin/sigsci-agent &

