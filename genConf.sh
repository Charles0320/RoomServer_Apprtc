#/bin/sh

srcFile='./conf/constants.py.template'
dstFile='./src/app_engine/constants.py'

if [ ! -f $dstFile ];then
    echo "$dstFile is not exsited"
    echo 'Now copy file ...'
    cp $srcFile $dstFile
    echo 'copy file success'

else
    echo "$dstFile is exsited"

fi


if [ ! -f /lib/systemd/system/avchat-apprtc.service ]; then

	echo "copy avchat-apprtc.service ...."
	cp ./conf/avchat-apprtc.service /lib/systemd/system/

else
	echo "avchat-apprtc.service is existed"

fi

if [ ! -f /usr/bin/avchat-apprtc-server ]; then

	echo "copy aavchat-apprtc-server ...."
	cp ./conf/avchat-apprtc-server /usr/bin/
else
	echo "avchat-apprtc-server is existed"

fi


echo "success"



