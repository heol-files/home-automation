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
mkdir -p ${BASE}/log
mkdir -p ${BASE}/data

docker run --name mymqtt \
	-dit \
	-p 1883:1883 \
	--restart unless-stopped \
	-v ${BASE}/config:/mosquitto/config \
	-v ${BASE}/data:/mosquitto/data \
	-v ${BASE}/log:/mosquitto/log \
	-u $(id -u):$(id -g) \
	eclipse-mosquitto

