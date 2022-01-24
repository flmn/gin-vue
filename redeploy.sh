#!/usr/bin/env bash

service="gin-vue"

set -e;

old_container=`docker ps -a | grep "$service" | awk '{print $1}'`
if [ $old_container ]; then
  docker stop $old_container
  docker rm $old_container
fi

old_image=`docker images | grep "$service" | awk '{print $3}'`
if [ $old_image ]; then
  docker image rm $old_image
fi

docker build -t $service .
docker run --restart always -d --name $service -p 8888:8888 -e TZ=Asia/Shanghai $service
