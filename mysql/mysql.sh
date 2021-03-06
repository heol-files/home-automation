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

docker run --name mysql_srv \
	-dit \
	-p 3306:3306 \
	-v /etc/localtime:/etc/localtime:ro \
	-v /etc/timezone:/etc/timezone:ro \
	-v ${BASE}/conf:/etc/mysql/conf.d \
	-v /data/databases/mysql_dir:/var/lib/mysql \
	--restart unless-stopped \
	-u $(id -u):$(id -g) \
	mysql

