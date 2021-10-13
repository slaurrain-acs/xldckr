## launch

make
make upd


## test ssh service

apt install net-tools lsof

netstat -plant | grep :22
lsof -i

service ssh start

## usage

ssh -p 2222 root@localhost
ssh -p 2222 docker@localhost

