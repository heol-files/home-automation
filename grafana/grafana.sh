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

mkdir -p ${BASE}/data/plugins
mkdir -p ${BASE}/log

# First run on new image add:
# -e "GF_SECURITY_ADMIN_PASSWORD=<secret>" \

docker run \
        -dit \
	--name grafana \
	--link mymqtt:mqttbroker \
	--link mysql_srv:mysql_srv \
	--mount type=bind,source=${BASE}/conf,destination=/etc/grafana \
	--mount type=bind,source=${BASE}/data,destination=/var/lib/grafana \
	--mount type=bind,source=${BASE}/log,destination=/var/log/grafana \
	-p 3000:3000 \
	--restart=always \
	-e "GF_INSTALL_PLUGINS=briangann-gauge-panel" \
	grafana:my_build


