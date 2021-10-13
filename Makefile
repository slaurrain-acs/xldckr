all: build

PROJECT=debian-ssh
CONTAINER_NAME=xavierl_devenv_ctn
IMAGE_NAME=xavierl_devenv_img::
DOCKER_USER=docker
REMOTE_ROOT=-w '/root'

listctn: 
	docker container ls

listimg:
	docker image ls

rembash:
	docker exec -ti $(CONTAINER_NAME) bash

getip:
	docker inspect $(CONTAINER_NAME) | grep "IPAddress"

restartapache:
	docker exec  $(REMOTE_ROOT) $(CONTAINER_NAME) service apache2 restart

startapache:
	docker exec   $(REMOTE_ROOT) $(CONTAINER_NAME) service apache2 start

stopall:
	docker stop $$(docker ps -q -a)

##cleaning
dri:
	docker rmi $$(docker images -q)

drmf: 
	docker rm -f $$(docker ps -q -a)

clnall: stopall drmf dri prune

clnright:
	docker exec  $remote_root $(CONTAINER_NAME) bash -c '/root/install/clnright.sh'

prune:
	docker image prune -a

erase: stopall
	docker container rm $(CONTAINER_NAME) && docker image rm $$(docker images '*$(CONTAINER_NAME)*')
#
# launch
build:
	docker-compose build

up:
	docker-compose up
upd: 
	docker-compose up -d


.FORCE: