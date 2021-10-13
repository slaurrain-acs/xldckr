FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive
ENV LSB_RELEASE=bullseye
WORKDIR "/root"
RUN apt-get update && apt-get install -y nano \
    apt-utils \    
    xz-utils \ 
    apache2 \
    supervisor;

COPY /conf/supervisord.conf /etc/supervisor/conf.d

#droits 

RUN mkdir /root/tmp; \
  apt-get clean; \
  chown -R www-data:www-data /var/www/html && chmod -R g+s /var/www/html;\
  chmod -R 777 /var/www/html; 

EXPOSE 80
ENTRYPOINT ["/usr/bin/supervisord"]
