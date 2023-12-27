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
rm -f ${BASE}/data/zw.txt

docker run --name nodered \
	-dit \
	-p 1880:1880 \
	-p 3001:3001 \
	--device=/dev/ttyUSBZwave \
	-v ${BASE}/data:/data \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-e TZ=Europe/Stockholm \
	--restart unless-stopped \
	--link mymqtt:mqttbroker \
	--link postgres_srv:postgres_srv \
	-u $(id -u):$(id -g) \
	--group-add dialout \
	nodered/node-red

#	--link mysql_srv:mysql_srv \

