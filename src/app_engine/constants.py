# Copyright 2015 Google Inc. All Rights Reserved.

"""AppRTC Constants.

This module contains the constants used in AppRTC Python modules.
"""
import os

BASE_URL='192.168.1.100'
TURN_BASE_URL='192.168.1.100'

# Deprecated domains which we should to redirect to REDIRECT_URL.
REDIRECT_DOMAINS =  [
  'apprtc.appspot.com', 'apprtc.webrtc.org', 'www.appr.tc'
]
# URL which we should redirect to if matching in REDIRECT_DOMAINS.
REDIRECT_URL = 'https://appr.tc'

ROOM_MEMCACHE_EXPIRATION_SEC = 60 * 60 * 24
MEMCACHE_RETRY_LIMIT = 100

LOOPBACK_CLIENT_ID = 'LOOPBACK_CLIENT_ID'

ROOM_REQUEST_ID = 'ROOM_REQUEST_ID'

ROOM_REUSE_MAX = 1000

TURN_TCP_SERVER = "turn:%s:3479?transport=tcp" % (TURN_BASE_URL)
TURN_UDP_SERVER = "turn:%s:3479?transport=udp" % (TURN_BASE_URL)
STUN_SERVER = "stun:%s:3479" % (TURN_BASE_URL)
HTTP_BASE_URL = "http://%s" % (BASE_URL)
COLIDER_BASE_URL = "%s/colider" % (BASE_URL)


TURN_SERVER_OVERRIDE = [
   {
     "urls": [
       TURN_TCP_SERVER,
       TURN_UDP_SERVER
     ],
     "username": "charles",
     "credential": "123456"
   },
   {
     "urls": [
       STUN_SERVER
     ]

   }
 ]

# TODO(jansson): Remove once AppRTCDemo on iOS supports ICE_SERVER.
#TURN_BASE_URL = 'https://computeengineondemand.appspot.com'
TURN_BASE_URL = "%s/avchat" % (HTTP_BASE_URL)
TURN_URL_TEMPLATE = '%s/turn.php?username=%s&key=%s'
CEOD_KEY = '1234'

ICE_SERVER_BASE_URL = "%s/avchat" % (HTTP_BASE_URL)
#ICE_SERVER_BASE_URL = 'https://networktraversal.googleapis.com'
#ICE_SERVER_URL_TEMPLATE = '%s/v1alpha/iceconfig?key=%s'
ICE_SERVER_URL_TEMPLATE = '%s/v1alpha/iceconfig/%s'
#ICE_SERVER_API_KEY = os.environ.get('ICE_SERVER_API_KEY')
ICE_SERVER_API_KEY = '1234567'


CALLSTATS_PARAMS = {
  'appId': os.environ.get('CALLSTATS_APP_ID'),
  'appSecret': os.environ.get('CALLSTATS_APP_SECRET')
}

# Dictionary keys in the collider instance info constant.
WSS_INSTANCE_HOST_KEY = 'host_port_pair'
WSS_INSTANCE_NAME_KEY = 'vm_name'
WSS_INSTANCE_ZONE_KEY = 'zone'
WSS_INSTANCES = [{
    WSS_INSTANCE_HOST_KEY: COLIDER_BASE_URL,#'apprtc-ws.webrtc.org:443',
    WSS_INSTANCE_NAME_KEY: 'wsserver-std',
    WSS_INSTANCE_ZONE_KEY: 'us-central1-a'
}, {
    WSS_INSTANCE_HOST_KEY: COLIDER_BASE_URL,#'apprtc-ws-2.webrtc.org:443',
    WSS_INSTANCE_NAME_KEY: 'wsserver-std-2',
    WSS_INSTANCE_ZONE_KEY: 'us-central1-f'
}]

WSS_HOST_PORT_PAIRS = [ins[WSS_INSTANCE_HOST_KEY] for ins in WSS_INSTANCES]

# memcache key for the active collider host.
WSS_HOST_ACTIVE_HOST_KEY = 'wss_host_active_host'

# Dictionary keys in the collider probing result.
WSS_HOST_IS_UP_KEY = 'is_up'
WSS_HOST_STATUS_CODE_KEY = 'status_code'
WSS_HOST_ERROR_MESSAGE_KEY = 'error_message'

RESPONSE_ERROR = 'ERROR'
RESPONSE_ROOM_FULL = 'FULL'
RESPONSE_UNKNOWN_ROOM = 'UNKNOWN_ROOM'
RESPONSE_UNKNOWN_CLIENT = 'UNKNOWN_CLIENT'
RESPONSE_DUPLICATE_CLIENT = 'DUPLICATE_CLIENT'
RESPONSE_SUCCESS = 'SUCCESS'
RESPONSE_INVALID_REQUEST = 'INVALID_REQUEST'

IS_DEV_SERVER = os.environ.get('APPLICATION_ID', '').startswith('dev')

BIGQUERY_URL = 'https://www.googleapis.com/auth/bigquery'

# Dataset used in production.
BIGQUERY_DATASET_PROD = 'prod'

# Dataset used when running locally.
BIGQUERY_DATASET_LOCAL = 'dev'

# BigQuery table within the dataset.
BIGQUERY_TABLE = 'analytics'
