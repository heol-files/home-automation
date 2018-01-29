#!/bin/bash

get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     $( cd -P "$( dirname "$SOURCE" )" )
     pwd
}

BASE=$(get_script_dir)
mkdir -p ${BASE}/data

docker run --name nodered \
	-dit \
	-p 1880:1880 \
	-v ${BASE}/data:/data \
	--restart unless-stopped \
	--link mymqtt:mqttbroker \
	--link mysql_srv:mysql_srv \
	-u $(id -u):$(id -g) \
	nodered/node-red-docker

