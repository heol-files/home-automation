#!/bin/bash
docker stop mymqtt
for cont in $(docker ps -q -a -f status=exited); do docker rm $cont; done
docker pull eclipse-mosquitto
for img in $(docker images -f "dangling=true" -q); do docker rmi $img; done

