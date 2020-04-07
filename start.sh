#!/bin/sh
/bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;' &
/usr/sbin/sigsci-agent
