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

docker stop grafana 
docker rm grafana
docker pull grafana/grafana
docker build --tag grafana:my_build --build-arg MY_USER=$(id -u) --build-arg MY_GROUP=$(id -g) .


