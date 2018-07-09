启动RoomServer_Apprtc步骤:
1、./setup.sh 运行脚本
2、修改启动参数,位置/usr/bin/avchat-apprtc-server
    (1)host 默认0.0.0.0
    (2)port 端口号，默认8080
    (3)APPRTC_BASE_URL 房间服务器外网地址.
    (4)COLLIDER_BASE_URL 信令服务器(RoomServer_Collider)地址.
    (5)COLIDER_INNER_PORT 信令服务器地址端口号.
    (6)ICE_SERVER_BASE_URL SimpleWebServer地址.
    (7)TURN_BASE_URL 穿透服务器备份地址.
    (8)TURN_SERVER_PORT 穿透服务器默认端口号.
    (9)IS_TLS_SUPPORT 是否支持tls加密，默认为False.
    (10)HTTP_PREX_PROTOCAL 外网请求是http还是https.

    
3、启动apprtc
  (1)手动启动
  systemctl start avchat-apprtc.service
 （2）当系统重启时候，服务自启动
