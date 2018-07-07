启动FaceRpcServer步骤:
1、./setup.sh 运行脚本
2、修改启动参数,位置/usr/bin/facerpcserver
    (1)host 默认0.0.0.0
    (2)port 端口号，默认9000
    (3)redisHost redis地址.
    (4)redisPasswd redis密码.
    (5)redisDb redis数据库，默认为1.
3、启动facerpcserver
  (1)手动启动
  systemctl start facerpcserver.service
 （2）当系统重启时候，服务自启动
