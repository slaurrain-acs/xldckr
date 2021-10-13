FROM debian:bullseye-slim
#
#
#
ENV DEBIAN_FRONTEND=noninteractive 
# Install packages

WORKDIR "/root"

RUN apt-get update && apt-get -y install openssh-server sudo \
    nano \
    apt-utils \    
    xz-utils \ 
    apache2 \
    supervisor;

#map supervisor conf
COPY /conf/supervisord.conf /etc/supervisor/conf.d

ADD install/set_root_pw.sh /root/set_root_pw.sh
ADD install/run.sh /root/run.sh
RUN chmod +x /root/*.sh
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
  && sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && touch /root/.Xauthority \
  && true

## Set a default user. Available via runtime flag `--user docker`
## Add user to 'staff' group, granting them write privileges to /usr/local/lib/R/site.library
## User should also have & own a home directory, but also be able to sudo
RUN useradd docker \
        && passwd -d docker \
        && mkdir /home/docker \
        && chown docker:docker /home/docker \
        && addgroup docker staff \
        && addgroup docker sudo \
        && true


EXPOSE 22 80
#CMD ["/run.sh"]
ENTRYPOINT ["/usr/bin/supervisord"]

