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
cd ${BASE}

#First time with no database add:
# 	-e MYSQL_ROOT_PASSWORD=<root passwd> \

docker run --name kodisql_srv \
	-dit \
	-p 13306:3306 \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-v ${BASE}/conf:/etc/mysql/conf.d \
	-v /data/databases/kodisql_dir:/var/lib/mysql \
	--restart unless-stopped \
 	-e MYSQL_ROOT_PASSWORD=HeRoLo \
	-u $(id -u):$(id -g) \
	mysql:5.7

