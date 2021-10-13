project="wb"

# version www
#VOIR
volumes="-v '$(pwd):/app' -v '$(pwd)/www:/var/www' -v '$(pwd)/src:/root/src' -v '$(pwd)/docker/apache2/apache2.conf:/etc/apache2/apache2.conf'"

workdir="-w '/app'"
remote_root="-w '/root'"
links=""
ports=""
logs=""
image="img_xavierl_devenv"
container="xavierl_devenv"

function rename() {
  cmd="docker tag $imageorg $image"
}


function npm() {
   cmd="docker run --rm -ti $volumes $workdir $image bash -c 'set -e && npm $@'"
   eval $cmd
}

function npminstall() {
   cmd="docker exec  $remote_root $container npm install"   
   eval $cmd
}

function upd() {
   cmd="docker-compose up -d"
   eval $cmd
}

function up() {
   cmd="docker-compose up"
   eval $cmd
}

function drm() {
   cmd='docker rm $(docker ps -q -a)'
   eval $cmd
}

function drmf() {
   cmd='docker rm -f $(docker ps -q -a)'
   eval $cmd
}

function dri() {
   cmd='docker rmi $(docker images -q)'
   eval $cmd
}

function logs() {
   cmd="docker logs $logs"
   eval $cmd
}

function stopall() {
   cmd="docker stop $(docker ps -q -a)"
   eval $cmd
}

function stop() {
   cmd="docker stop $container"
   eval $cmd
}

function listctn() {
   cmd="docker ps -a"
   eval $cmd
}

function listimg() {
   cmd="docker image ls"
   eval $cmd
}

function rembash() {
  cmd="docker exec -i -t $container /bin/bash"
  eval $cmd
}


function restart(){ 
  cmd="docker exec  $remote_root $container service apache2 restart"
    
  eval $cmd
}

function start(){ 
  cmd="docker exec  $remote_root $container service apache2 start"
    
  eval $cmd
}

function getip () {
  cmd='docker inspect $container | grep "IPAddress"'
  eval $cmd
}

function clnall(){
   stopall
   drmf
   dri
   prune
}

function clnright(){ 
  cmd="docker exec  $remote_root $container bash -c '/root/install/clnright.sh'"
  eval $cmd
} 

function prune(){
  cmd='docker image prune -a'
  eval $cmd
}

function erase(){
  stopall
  cmd='docker container rm $container && docker image rm $(docker images '*$container*')'
  eval $cmd
}

"$@"
