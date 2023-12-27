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

docker run --name postgres_srv \
	-dit \
	-e POSTGRES_PASSWORD=mypsqlpw! \
	-p 5432:5432 \
	-v /data/databases/postgres_dir:/var/lib/postgresql/data \
	--restart unless-stopped \
	-u $(id -u):$(id -g) \
	postgres:13

