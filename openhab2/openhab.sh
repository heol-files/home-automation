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

mkdir -p ${BASE}/userdata
mkdir -p ${BASE}/addons
mkdir -p ${BASE}/.java

docker run \
        -dit \
	--name openhab \
	--net=host \
	--device=/dev/ttyUSBZwave:rwx \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-v ${BASE}/conf:/openhab/conf \
	-v ${BASE}/userdata:/openhab/userdata \
	-v ${BASE}/addons:/openhab/addons \
	-v ${BASE}/.java:/openhab/.java \
	-e USER_ID=$(id -u) \
	-e GROUP_ID=$(id -g) \
	-e OPENHAB_HTTP_PORT=9070 \
	-e OPENHAB_HTTPS_PORT=9071 \
	-e EXTRA_JAVA_OPTS="-Dgnu.io.rxtx.SerialPorts=/dev/ttyUSBZwave" \
	--restart=always \
	openhab/openhab:2.2.0-amd64-debian

