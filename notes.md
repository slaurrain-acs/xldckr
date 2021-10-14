## launch

make
make upd

## usage

ssh -p 2222 docker@localhost
## test ssh service

apt install net-tools lsof

netstat -plant | grep :22
lsof -i

service ssh start


# SSH
RUN mkdir -p /var/run/sshd

# authorize SSH connection with root account
RUN sed -i '/^#/!s/PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN service ssh restart

# change password root
RUN echo "root:docker"|chpasswd

#
    echo "docker:docker"  | tee -a pss; \