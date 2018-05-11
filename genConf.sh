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
