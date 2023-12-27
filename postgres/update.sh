#!/bin/bash
docker stop postgres_srv
for cont in $(docker ps -q -a -f status=exited); do docker rm $cont; done
docker pull postgres:latest
for img in $(docker images -f "dangling=true" -q); do docker rmi $img; done

