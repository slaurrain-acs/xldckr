FROM debian:bullseye-slim
#
#
#
ENV DEBIAN_FRONTEND=noninteractive 
# Install packages

WORKDIR "/root"
ADD conf/pssdocker /root/pssdocker
RUN apt-get update && apt-get -y install openssh-server sudo \
    nano \
    apt-utils \    
    xz-utils \ 
    apache2 \
    supervisor;

#map supervisor conf
COPY /conf/supervisord.conf /etc/supervisor/conf.d

# SSH
RUN mkdir -p /var/run/sshd

# authorize SSH connection with root account
RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory, but also be able to sudo
RUN useradd docker; \
        mkdir /home/docker; \
        chown docker:docker /home/docker; \
        addgroup docker staff; \
        addgroup docker sudo; \
        chpasswd < pssdocker;
    

EXPOSE 22 80

ENTRYPOINT ["/usr/bin/supervisord"]

