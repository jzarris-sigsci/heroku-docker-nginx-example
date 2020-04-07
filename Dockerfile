FROM nginx:1.17.9

# initial setup
RUN apt-get update
RUN apt-get install -y apt-transport-https wget sed curl gnupg

# add the signal sciences repo to our apt sources
RUN wget -qO - https://apt.signalsciences.net/release/gpgkey | apt-key add -
RUN echo "deb https://apt.signalsciences.net/release/debian/ jessie main" > /etc/apt/sources.list.d/sigsci-release.list
RUN apt-get update
RUN wget -qO - https://apt.signalsciences.net/nginx/gpg.key | apt-key add -
RUN echo "deb https://apt.signalsciences.net/nginx/distro jessie main" > /etc/apt/sources.list.d/sigsci-nginx.list
RUN apt-get update

# install and sigsci agent and nginx native module
RUN apt-get -y install sigsci-agent
RUN apt-get install nginx-module-sigsci-nxo=1.17.9*


COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY static-html /usr/share/nginx/html

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off' && /usr/sbin/sigsci-agent;
