FROM nginx:1.17.9


COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html

ENTRYPOINT nginx -g 'daemon off;'
