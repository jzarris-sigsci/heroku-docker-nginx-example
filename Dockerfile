FROM debian:8

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
RUN apt-get -y install nginx

# install and configure the sigsci agent
RUN apt-get -y install sigsci-agent
# install the sigsci module
#RUN apt-get -y install sigsci-module-nginx

RUN  mkdir /app && mkdir /etc/sigsci
COPY agent-reverse-proxy.conf /etc/sigsci/agent.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/sites-enabled/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

ENTRYPOINT ["/app/start.sh"]
