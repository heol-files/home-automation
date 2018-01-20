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
mkdir -p ${BASE}/conf
mkdir -p ${BASE}/userdata
mkdir -p ${BASE}/addons
mkdir -p ${BASE}/.java

docker run \
        -dit \
	--name openhab \
	--tty \
	--device=/dev/ttyUSB-ZStick-5G \
	--link mymqtt:mqttbroker \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-v ${BASE}/conf:/openhab/conf \
	-v ${BASE}/userdata:/openhab/userdata \
	-v ${BASE}/addons:/openhab/addons \
	-v ${BASE}/.java:/openhab/.java \
	-p 9070:8080 \
	-p 9071:8443 \
	-e USER_ID=$(id -u) \
	-e GROUP_ID=$(id -g) \
	-e EXTRA_JAVA_OPTS="-Dgnu.io.rxtx.SerialPorts=/dev/ttyUSB-ZStick-5G" \
	--restart=always \
	openhab/openhab:2.2.0-amd64-debian

