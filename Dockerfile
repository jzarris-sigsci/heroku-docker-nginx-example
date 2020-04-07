FROM nginx:1.17.9

COPY default.conf.template /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html

CMD /bin/bash -c nginx -g 'daemon off;'
