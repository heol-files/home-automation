#!/bin/bash
docker stop nodered
for cont in $(docker ps -q -a -f status=exited); do docker rm $cont; done
docker pull nodered/node-red
for img in $(docker images -f "dangling=true" -q); do docker rmi $img; done

