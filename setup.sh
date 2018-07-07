#!/bin/bash

SCRIPT_DIR=$(realpath $(dirname $0))
echo "script dir:${SCRIPT_DIR}"

WORK_PATH="${HOME}/CharlesWork"

GOOGLE_APP_ENGINE="${WORK_PATH}/google_appengine"

SYSTEM_DIR='/lib/systemd/system'

CONFIG_NAME='avchat-apprtc.service'

EXEC_FILE='/usr/bin/avchat-apprtc-server'

SYSTEM_CONFIG="${SYSTEM_DIR}/${CONFIG_NAME}"



if [ -f "${SCRIPT_DIR}/src/app_engine/apprtc.py" ]
then
	PROJECT_PATH="${SCRIPT_DIR}"
else
	PROJECT_PATH="${WORK_PATH}/RoomServer_Apprtc"
fi

DISTRIBUTOR_ID=$(lsb_release -is)
echo "DISTRIBUTOR_ID = ${DISTRIBUTOR_ID}"

mkdir -pv "${WORK_PATH}" && cd "${WORK_PATH}" || exit 1

function jwaoo_install_depends()
{
	case "${DISTRIBUTOR_ID}" in
		Ubuntu)
			apt-get -y install git g++ make libtool automake autoconf python-pip python-webtest nodejs grunt-cli|| return 1
			;;

		CentOS)
			yum -y install gcc-c++ libtool python-pip python-webtest nodejs grunt-cli || return 1
			;;

		*)
			echo "Invalid Distributor ID!"
			return 1
	esac
}






function jwaoo_git_clone()
{
	echo "git clone $@"
	[ -d "$2" ] || git clone "$1" "$2" || return 1
	cd "$2" || return 1
	[ -z "$3" ] || git checkout "$3" || return 1
}

function jwaoo_install_appengine()
{
	echo "Build: ${GOOGLE_APP_ENGINE}"
	jwaoo_git_clone "http://180.169.167.166:6380/git/google_appengine.git" "${GOOGLE_APP_ENGINE}" "v1.9.72" || return 1

}



function jwaoo_install_apprtc()
{
	echo "Build: ${PROJECT_PATH}"
	jwaoo_git_clone "http://180.169.167.166:6380/git/RoomServer_Apprtc.git" "${PROJECT_PATH}" || return 1

	npm install

	grunt build

	jwaoo_apprtc_systemd

	return 1


}



function jwaoo_apprtc_systemd()
{
	echo '-----jwaoo_apprtc_systemd-----'
	if [ ! -f $EXEC_FILE ]; then
		echo '#!/bin/bash' > $EXEC_FILE
		echo "cd ${PROJECT_PATH}" >> $EXEC_FILE
		echo "${GOOGLE_APP_ENGINE}/dev_appserver.py --host 0.0.0.0 --port 8080 \" >> $EXEC_FILE
		echo '--env_var APPRTC_BASE_URL=192.168.10.201 \' >> $EXEC_FILE
		echo '--env_var COLLIDER_BASE_URL=192.168.10.201 \' >> $EXEC_FILE
		echo '--env_var COLIDER_INNER_PORT=8089 \' >> $EXEC_FILE
		echo '--env_var ICE_SERVER_BASE_URL=http://192.168.10.250:8081/simpleweb \' >> $EXEC_FILE
		echo '--env_var TURN_BASE_URL=192.168.10.201 \' >> $EXEC_FILE
		echo '--env_var TURN_SERVER_PORT=3478 \' >> $EXEC_FILE
		echo '--env_var IS_TLS_SUPPORT=False \' >> $EXEC_FILE
		echo '--env_var HTTP_PREX_PROTOCAL=http \' >> $EXEC_FILE
		chmod +x $EXEC_FILE

	fi
	
	echo '[Unit]' > $SYSTEM_CONFIG
	echo 'Description=Apprtc' >> $SYSTEM_CONFIG
	echo 'After=network.target' >> $SYSTEM_CONFIG
	echo '' >> $SYSTEM_CONFIG
	echo '[Service]' >> $SYSTEM_CONFIG
	echo 'Type=simple' >> $SYSTEM_CONFIG
	echo 'Restart=always' >> $SYSTEM_CONFIG
	echo 'PIDFile=/run/avchat/avchat-apprtc.pid' >> $SYSTEM_CONFIG
	echo "ExecStart=/bin/bash ${EXEC_FILE}" >> $SYSTEM_CONFIG
	echo '' >> $SYSTEM_CONFIG
	echo '[Install]' >> $SYSTEM_CONFIG
	echo 'WantedBy=multi-user.target' >> $SYSTEM_CONFIG

	systemctl daemon-reload

	systemctl enable $CONFIG_NAME

	return 1
	
}


case "$1" in
	depends)
		jwaoo_install_depends
		;;
	appengine)
		jwaoo_install_appengine
		;;

	apprtc)
		jwaoo_install_apprtc
		;;

	systemd)
		jwaoo_facerpcserver_systemd
		;;

	*)
		jwaoo_install_depends && jwaoo_install_appengine && jwaoo_install_apprtc
		;;
esac




























