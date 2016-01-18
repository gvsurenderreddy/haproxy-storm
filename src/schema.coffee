schema_haproxy =
    name: "haproxy"
    type: "object"
    required: true
    additionalProperties: false
    properties:
        "global":
            name: "global"
            type: "object"
            required: true            
            properties:
                    "chroot": {type:"string", required:false}
                    "crt-base": {type:"string", required:false}
                    "cpu-map": {type:"string", required:false}
                    "daemon": {type:"string", required:false}
                    "description": {type:"string", required:false}
                    "deviceatlas-json-file": {type:"string", required:false}
                    "deviceatlas-log-level ": {type:"string", required:false}
                    "deviceatlas-separator": {type:"string", required:false}
                    "deviceatlas-properties-cookie": {type:"string", required:false}
                    "external-check": {type:"string", required:false}
                    "gid": {type:"string", required:false}
                    "group": {type:"string", required:false}
                    "log":items: {type:"string", required:false}
                    "log-tag": {type:"string", required:false}
                    "log-send-hostname": {type:"string", required:false}
                    "lua-load": {type:"string", required:false}
                    "nbproc": {type:"string", required:false}
                    "node": {type:"string", required:false}
                    "pidfile": {type:"string", required:false}
                    "uid": {type:"string", required:false}
                    "ulimit-n": {type:"string", required:false}
                    "user": {type:"string", required:false}
                    "stats": items: {type:"object", required:false}
                    "ssl-default-bind-ciphers": {type:"string", required:false}
                    "ssl-default-bind-options": {type:"string", required:false}
                    "ssl-default-server-ciphers": {type:"string", required:false}
                    "ssl-default-server-options": {type:"string", required:false}
                    "ssl-dh-param-file": {type:"string", required:false}
                    "ssl-server-verify": {type:"string", required:false}
                    "unix-bind": {type:"string", required:false}
                    "51degrees-data-file": {type:"string", required:false}
                    "51degrees-property-name-list": items: {type:"string", required:false} 
                    "51degrees-property-separator": {type:"string", required:false}
                    "51degrees-cache-size": {type:"string", required:false}
                    "max-spread-checks": {type:"string", required:false}
                    "maxconn": {type:"string", required:false}
                    "maxconnrate": {type:"string", required:false}
                    "maxcomprate": {type:"string", required:false}
                    "maxcompcpuusage": {type:"string", required:false}
                    "maxpipes": {type:"string", required:false}
                    "maxsessrate": {type:"string", required:false}
                    "maxsslconn": {type:"string", required:false}
                    "maxsslrate": {type:"string", required:false}
                    "maxzlibmem": {type:"string", required:false}
                    "noepoll": {type:"string", required:false}
                    "nokqueue": {type:"string", required:false}
                    "nopoll": {type:"string", required:false}
                    "nosplice": {type:"string", required:false}
                    "nogetaddrinfo": {type:"string", required:false}
                    "spread-checks": {type:"string", required:false}
                    "server-state-base": {type:"string", required:false}
                    "server-state-file": {type:"string", required:false}
                    "tune.buffers.limit": {type:"string", required:false}
                    "tune.buffers.reserve": {type:"string", required:false}
                    "tune.bufsize": {type:"string", required:false}
                    "tune.chksize": {type:"string", required:false}
                    "tune.comp.maxlevel": {type:"string", required:false}
                    "tune.http.cookielen": {type:"string", required:false}
                    "tune.http.maxhdr": {type:"string", required:false}
                    "tune.idletimer": {type:"string", required:false}
                    "tune.lua.forced-yield": {type:"string", required:false}
                    "tune.lua.maxmem": {type:"string", required:false}
                    "tune.lua.session-timeout": {type:"string", required:false}
                    "tune.lua.task-timeout": {type:"string", required:false}
                    "tune.lua.service-timeout": {type:"string", required:false}
                    "tune.maxaccept": {type:"string", required:false}
                    "tune.maxpollevents": {type:"string", required:false}
                    "tune.maxrewrite": {type:"string", required:false}
                    "tune.pattern.cache-size": {type:"string", required:false}
                    "tune.pipesize": {type:"string", required:false}
                    "tune.rcvbuf.client": {type:"string", required:false}
                    "tune.rcvbuf.server": {type:"string", required:false}
                    "tune.sndbuf.client": {type:"string", required:false}
                    "tune.sndbuf.server": {type:"string", required:false}
                    "tune.ssl.cachesize": {type:"string", required:false}
                    "tune.ssl.lifetime": {type:"string", required:false}
                    "tune.ssl.force-private-cache": {type:"string", required:false}
                    "tune.ssl.maxrecord": {type:"string", required:false}
                    "tune.ssl.default-dh-param": {type:"string", required:false}
                    "tune.ssl.ssl-ctx-cache-size": {type:"string", required:false}
                    "tune.vars.global-max-size": {type:"string", required:false}
                    "tune.vars.reqres-max-size": {type:"string", required:false}
                    "tune.vars.sess-max-size": {type:"string", required:false}
                    "tune.vars.txn-max-size": {type:"string", required:false}
                    "tune.zlib.memlevel": {type:"string", required:false}
                    "tune.zlib.windowsize": {type:"string", required:false}
                    "debug": {type:"string", required:false}
                    "quiet": {type:"string", required:false}
        "defaults":
            name: "defaults"
            type: "object"
            required: false            
            properties:
                    "balance": {type:"string", required:false}
                    "backlog": {type:"string", required:false}
                    "bind-process": {type:"string", required:false}
                    "clitimeout": {type:"string", required:false}
                    "compression": {type:"string", required:false}
                    "contimeout": {type:"string", required:false}
                    "cookie": {type:"string", required:false}
                    "default-server": {type:"string", required:false}
                    "default_backend": {type:"string", required:false}
                    "disabled": {type:"string", required:false}
                    "email-alert from": {type:"string", required:false}
                    "email-alert level": {type:"string", required:false}
                    "email-alert mailers": {type:"string", required:false}
                    "email-alert myhostname": {type:"string", required:false}
                    "email-alert to": {type:"string", required:false}
                    "enabled": {type:"string", required:false}
                    "errorfile": {type:"string", required:false}
                    "errorloc": {type:"string", required:false}
                    "errorloc303": {type:"string", required:false}
                    "force-persist": {type:"string", required:false}
                    "fullconn": {type:"string", required:false}
                    "grace": {type:"string", required:false}
                    "hash-type": {type:"string", required:false}
                    "http-check disable-on-404": {type:"string", required:false}
                    "http-check send-state": {type:"string", required:false}
                    "http-reuse": {type:"string", required:false}
                    "load-server-state-from-file": {type:"string", required:false}
                    "log": {type:"string", required:false}
                    "log-format": {type:"string", required:false}
                    "log-format-sd": {type:"string", required:false}
                    "log-tag": {type:"string", required:false}
                    "max-keep-alive-queue": {type:"string", required:false}
                    "maxconn": {type:"string", required:false}
                    "mode": {type:"string", required:false}
                    "monitor-net": {type:"string", required:false}
                    "monitor-uri": {type:"string", required:false}
                    "option": items: {type:"string", required:false}
                    "option abortonclose": {type:"string", required:false}
                    "option accept-invalid-http-request": {type:"string", required:false}
                    "option accept-invalid-http-response": {type:"string", required:false}
                    "option allbackups": {type:"string", required:false}
                    "option checkcache": {type:"string", required:false}
                    "option clitcpka": {type:"string", required:false}
                    "option contstats": {type:"string", required:false}
                    "option dontlog-normal": {type:"string", required:false}
                    "option dontlognull": {type:"string", required:false}
                    "option forceclose": {type:"string", required:false}
                    "option forwardfor": {type:"string", required:false}
                    "option http-buffer-request": {type:"string", required:false}
                    "option http-ignore-probes": {type:"string", required:false}
                    "option http-keep-alive": {type:"string", required:false}
                    "option http-no-delay": {type:"string", required:false}
                    "option http-pretend-keepalive": {type:"string", required:false}
                    "option http-server-close": {type:"string", required:false}
                    "option http-tunnel": {type:"string", required:false}
                    "option http-use-proxy-header": {type:"string", required:false}
                    "option httpchk": {type:"string", required:false}
                    "option httpclose": {type:"string", required:false}
                    "option httplog": {type:"string", required:false}
                    "option http_proxy": {type:"string", required:false}
                    "option independent-streams": {type:"string", required:false}
                    "option ldap-check": {type:"string", required:false}
                    "option external-check": {type:"string", required:false}
                    "option log-health-checks": {type:"string", required:false}
                    "option log-separate-errors": {type:"string", required:false}
                    "option logasap": {type:"string", required:false}
                    "option mysql-check": {type:"string", required:false}
                    "option nolinger": {type:"string", required:false}
                    "option originalto": {type:"string", required:false}
                    "option persist": {type:"string", required:false}
                    "option pgsql-check": {type:"string", required:false}
                    "option prefer-last-server": {type:"string", required:false}
                    "option redispatch": {type:"string", required:false}
                    "option redis-check": {type:"string", required:false}
                    "option smtpchk": {type:"string", required:false}
                    "option socket-stats": {type:"string", required:false}
                    "option splice-auto": {type:"string", required:false}
                    "option splice-request": {type:"string", required:false}
                    "option splice-response": {type:"string", required:false}
                    "option srvtcpka": {type:"string", required:false}
                    "option ssl-hello-chk": {type:"string", required:false}
                    "option tcp-check": {type:"string", required:false}
                    "option tcp-smart-accept": {type:"string", required:false}
                    "option tcp-smart-connect": {type:"string", required:false}
                    "option tcpka": {type:"string", required:false}
                    "option tcplog": {type:"string", required:false}
                    "option transparent": {type:"string", required:false}
                    "external-check command": {type:"string", required:false}
                    "external-check path": {type:"string", required:false}
                    "persist rdp-cookie": {type:"string", required:false}
                    "rate-limit sessions": {type:"string", required:false}
                    "redisp": {type:"string", required:false}
                    "redispatch": {type:"string", required:false}
                    "retries": {type:"string", required:false}
                    "server-state-file-name": {type:"string", required:false}
                    "source": {type:"string", required:false}
                    "srvtimeout": {type:"string", required:false}
                    "stats auth": {type:"string", required:false}
                    "stats enable": {type:"string", required:false}
                    "stats hide-version": {type:"string", required:false}
                    "stats realm": {type:"string", required:false}
                    "stats refresh": {type:"string", required:false}
                    "stats scope": {type:"string", required:false}
                    "stats show-desc": {type:"string", required:false}
                    "stats show-legends": {type:"string", required:false}
                    "stats show-node": {type:"string", required:false}
                    "stats uri": {type:"string", required:false}
                    "timeout check": {type:"string", required:false}
                    "timeout client": {type:"string", required:false}
                    "timeout client-fin": {type:"string", required:false}
                    "timeout clitimeout": {type:"string", required:false}
                    "timeout connect": {type:"string", required:false}
                    "timeout contimeout": {type:"string", required:false}
                    "timeout http-keep-alive": {type:"string", required:false}
                    "timeout http-request": {type:"string", required:false}
                    "timeout queue": {type:"string", required:false}
                    "timeout server": {type:"string", required:false}
                    "timeout server-fin": {type:"string", required:false}
                    "timeout srvtimeout": {type:"string", required:false}
                    "timeout tarpit": {type:"string", required:false}
                    "timeout tunnel": {type:"string", required:false}
                    "transparent": {type:"string", required:false}
                    "unique-id-format": {type:"string", required:false}
                    "unique-id-header": {type:"string", required:false}


        "listen":
            type: "array"
            items:
                name: "listen"
                type: "object"
                required: false            
                properties:
                    "name": {type:"string", required:false}                    
                    "bind": items: {type:"object", required:false}
                    "balance": {type:"string", required:false}
                    "acl": {type:"string", required:false}
                    "backlog": {type:"string", required:false}
                    "bind-process": {type:"string", required:false}
                    "block": {type:"string", required:false}
                    "capture cookie": {type:"string", required:false}
                    "capture request header": {type:"string", required:false}
                    "capture response header": {type:"string", required:false}
                    "clitimeout": {type:"string", required:false}
                    "compression": {type:"string", required:false}
                    "contimeout": {type:"string", required:false}
                    "cookie": items: {type:"string", required:false}
                    "declare capture": {type:"string", required:false}
                    "default-server": {type:"string", required:false}
                    "default_backend": {type:"string", required:false}
                    "description": {type:"string", required:false}
                    "disabled": {type:"string", required:false}
                    "dispatch": {type:"string", required:false}
                    "email-alert from": {type:"string", required:false}
                    "email-alert level": {type:"string", required:false}
                    "email-alert mailers": {type:"string", required:false}
                    "email-alert myhostname": {type:"string", required:false}
                    "email-alert to": {type:"string", required:false}
                    "enabled": {type:"string", required:false}
                    "errorfile": {type:"string", required:false}
                    "errorloc": {type:"string", required:false}
                    "errorloc303": {type:"string", required:false}
                    "force-persist": {type:"string", required:false}
                    "fullconn": {type:"string", required:false}
                    "grace": {type:"string", required:false}
                    "hash-type": {type:"string", required:false}
                    "http-check disable-on-404": {type:"string", required:false}
                    "http-check expect": {type:"string", required:false}
                    "http-check send-state": {type:"string", required:false}
                    "http-request": {type:"string", required:false}
                    "http-response": {type:"string", required:false}
                    "http-reuse": {type:"string", required:false}
                    "http-send-name-header": {type:"string", required:false}
                    "id": {type:"string", required:false}
                    "ignore-persist": {type:"string", required:false}
                    "load-server-state-from-file": {type:"string", required:false}
                    "log": {type:"string", required:false}
                    "log-format": {type:"string", required:false}
                    "log-format-sd": {type:"string", required:false}
                    "log-tag": {type:"string", required:false}
                    "max-keep-alive-queue": {type:"string", required:false}
                    "maxconn": {type:"string", required:false}
                    "mode": {type:"string", required:false}
                    "monitor fail": {type:"string", required:false}
                    "monitor-net": {type:"string", required:false}
                    "monitor-uri": {type:"string", required:false}
                    "option": items: {type:"string", required:false}
                    "option abortonclose": {type:"string", required:false}
                    "option accept-invalid-http-request": {type:"string", required:false}
                    "option accept-invalid-http-response": {type:"string", required:false}
                    "option allbackups": {type:"string", required:false}
                    "option checkcache": {type:"string", required:false}
                    "option clitcpka": {type:"string", required:false}
                    "option contstats": {type:"string", required:false}
                    "option dontlog-normal": {type:"string", required:false}
                    "option dontlognull": {type:"string", required:false}
                    "option forceclose": {type:"string", required:false}
                    "option forwardfor": {type:"string", required:false}
                    "option http-buffer-request": {type:"string", required:false}
                    "option http-ignore-probes": {type:"string", required:false}
                    "option http-keep-alive": {type:"string", required:false}
                    "option http-no-delay": {type:"string", required:false}
                    "option http-pretend-keepalive": {type:"string", required:false}
                    "option http-server-close": {type:"string", required:false}
                    "option http-tunnel": {type:"string", required:false}
                    "option http-use-proxy-header": {type:"string", required:false}
                    "option httpchk": {type:"string", required:false}
                    "option httpclose": {type:"string", required:false}
                    "option httplog": {type:"string", required:false}
                    "option http_proxy": {type:"string", required:false}
                    "option independent-streams": {type:"string", required:false}
                    "option ldap-check": {type:"string", required:false}
                    "option external-check": {type:"string", required:false}
                    "option log-health-checks": {type:"string", required:false}
                    "option log-separate-errors": {type:"string", required:false}
                    "option logasap": {type:"string", required:false}
                    "option mysql-check": {type:"string", required:false}
                    "option nolinger": {type:"string", required:false}
                    "option originalto": {type:"string", required:false}
                    "option persist": {type:"string", required:false}
                    "option pgsql-check": {type:"string", required:false}
                    "option prefer-last-server": {type:"string", required:false}
                    "option redispatch": {type:"string", required:false}
                    "option redis-check": {type:"string", required:false}
                    "option smtpchk": {type:"string", required:false}
                    "option socket-stats": {type:"string", required:false}
                    "option splice-auto": {type:"string", required:false}
                    "option splice-request": {type:"string", required:false}
                    "option splice-response": {type:"string", required:false}
                    "option srvtcpka": {type:"string", required:false}
                    "option ssl-hello-chk": {type:"string", required:false}
                    "option tcp-check": {type:"string", required:false}
                    "option tcp-smart-accept": {type:"string", required:false}
                    "option tcp-smart-connect": {type:"string", required:false}
                    "option tcpka": {type:"string", required:false}
                    "option tcplog": {type:"string", required:false}
                    "option transparent": {type:"string", required:false}
                    "external-check command": {type:"string", required:false}
                    "external-check path": {type:"string", required:false}
                    "persist rdp-cookie": {type:"string", required:false}
                    "rate-limit sessions": {type:"string", required:false}
                    "redirect": {type:"string", required:false}
                    "redisp": {type:"string", required:false}
                    "redispatch": {type:"string", required:false}
                    "reqadd": {type:"string", required:false}
                    "reqallow": {type:"string", required:false}
                    "reqdel": {type:"string", required:false}
                    "reqdeny": {type:"string", required:false}
                    "reqiallow": {type:"string", required:false}
                    "reqidel": {type:"string", required:false}
                    "reqideny": {type:"string", required:false}
                    "reqipass": {type:"string", required:false}
                    "reqirep": {type:"string", required:false}
                    "reqitarpit": {type:"string", required:false}
                    "reqpass": {type:"string", required:false}
                    "reqrep": {type:"string", required:false}
                    "reqtarpit": {type:"string", required:false}
                    "retries": {type:"string", required:false}
                    "rspadd": {type:"string", required:false}
                    "rspdel": {type:"string", required:false}
                    "rspdeny": {type:"string", required:false}
                    "rspidel": {type:"string", required:false}
                    "rspideny": {type:"string", required:false}
                    "rspirep": {type:"string", required:false}
                    "rsprep": {type:"string", required:false}
                    "server": items: {type:"object", required:false}
                    "server-state-file-name": {type:"string", required:false}
                    "source": {type:"string", required:false}
                    "srvtimeout": {type:"string", required:false}
                    "stats admin": {type:"string", required:false}
                    "stats auth": {type:"string", required:false}
                    "stats enable": {type:"string", required:false}
                    "stats hide-version": {type:"string", required:false}
                    "stats http-request": {type:"string", required:false}
                    "stats realm": {type:"string", required:false}
                    "stats refresh": {type:"string", required:false}
                    "stats scope": {type:"string", required:false}
                    "stats show-desc": {type:"string", required:false}
                    "stats show-legends": {type:"string", required:false}
                    "stats show-node": {type:"string", required:false}
                    "stats uri": {type:"string", required:false}
                    "stick match": {type:"string", required:false}
                    "stick on": {type:"string", required:false}
                    "stick store-request": {type:"string", required:false}
                    "stick store-response": {type:"string", required:false}
                    "stick-table": {type:"string", required:false}
                    "tcp-check connect": {type:"string", required:false}
                    "tcp-check expect": {type:"string", required:false}
                    "tcp-check send": {type:"string", required:false}
                    "tcp-check send-binary": {type:"string", required:false}
                    "tcp-request connection": {type:"string", required:false}
                    "tcp-request content": {type:"string", required:false}
                    "tcp-request inspect-delay": {type:"string", required:false}
                    "tcp-response content": {type:"string", required:false}
                    "tcp-response inspect-delay": {type:"string", required:false}
                    "timeout check": {type:"string", required:false}
                    "timeout client": {type:"string", required:false}
                    "timeout client-fin": {type:"string", required:false}
                    "timeout clitimeout": {type:"string", required:false}
                    "timeout connect": {type:"string", required:false}
                    "timeout contimeout": {type:"string", required:false}
                    "timeout http-keep-alive": {type:"string", required:false}
                    "timeout http-request": {type:"string", required:false}
                    "timeout queue": {type:"string", required:false}
                    "timeout server": {type:"string", required:false}
                    "timeout server-fin": {type:"string", required:false}
                    "timeout srvtimeout": {type:"string", required:false}
                    "timeout tarpit": {type:"string", required:false}
                    "timeout tunnel": {type:"string", required:false}
                    "transparent": {type:"string", required:false}
                    "unique-id-format": {type:"string", required:false}
                    "unique-id-header": {type:"string", required:false}
                    "use_backend": items: {type:"object", required:false}
                    "use-server": {type:"string", required:false}

        "frontend":
            type: "array"
            items:
                name: "frontend"
                type: "object"
                required: false                        
                properties:
                    "name": {type:"string", required:false}                    
                    "acl": {type:"string", required:false}
                    "backlog": {type:"string", required:false}
                    "bind": items: {type:"object", required:false}
                    "bind-process": {type:"string", required:false}
                    "block": {type:"string", required:false}
                    "capture cookie": {type:"string", required:false}
                    "capture request header": {type:"string", required:false}
                    "capture response header": {type:"string", required:false}
                    "clitimeout": {type:"string", required:false}
                    "compression": {type:"string", required:false}
                    "declare capture": {type:"string", required:false}
                    "default_backend": {type:"string", required:false}
                    "description": {type:"string", required:false}
                    "disabled": {type:"string", required:false}
                    "email-alert from": {type:"string", required:false}
                    "email-alert level": {type:"string", required:false}
                    "email-alert mailers": {type:"string", required:false}
                    "email-alert myhostname": {type:"string", required:false}
                    "email-alert to": {type:"string", required:false}
                    "enabled": {type:"string", required:false}
                    "errorfile": {type:"string", required:false}
                    "errorloc": {type:"string", required:false}
                    "errorloc303": {type:"string", required:false}
                    "force-persist": {type:"string", required:false}
                    "grace": {type:"string", required:false}
                    "http-request": {type:"string", required:false}
                    "http-response": {type:"string", required:false}
                    "id": {type:"string", required:false}
                    "ignore-persist": {type:"string", required:false}
                    "log": items: {type:"string", required:false}
                    "log-format": {type:"string", required:false}
                    "log-format-sd": {type:"string", required:false}
                    "log-tag": {type:"string", required:false}
                    "maxconn": {type:"string", required:false}
                    "mode": {type:"string", required:false}
                    "monitor fail": {type:"string", required:false}
                    "monitor-net": {type:"string", required:false}
                    "monitor-uri": {type:"string", required:false}
                    "option": items: {type:"string", required:false}
                    "option accept-invalid-http-request": {type:"string", required:false}
                    "option clitcpka": {type:"string", required:false}
                    "option contstats": {type:"string", required:false}
                    "option dontlog-normal": {type:"string", required:false}
                    "option dontlognull": {type:"string", required:false}
                    "option forceclose": {type:"string", required:false}
                    "option forwardfor": {type:"string", required:false}
                    "option http-buffer-request": {type:"string", required:false}
                    "option http-ignore-probes": {type:"string", required:false}
                    "option http-keep-alive": {type:"string", required:false}
                    "option http-no-delay": {type:"string", required:false}
                    "option http-pretend-keepalive": {type:"string", required:false}
                    "option http-server-close": {type:"string", required:false}
                    "option http-tunnel": {type:"string", required:false}
                    "option http-use-proxy-header": {type:"string", required:false}
                    "option httpclose": {type:"string", required:false}
                    "option httplog": {type:"string", required:false}
                    "option http_proxy": {type:"string", required:false}
                    "option independent-streams": {type:"string", required:false}
                    "option log-separate-errors": {type:"string", required:false}
                    "option logasap": {type:"string", required:false}
                    "option nolinger": {type:"string", required:false}
                    "option originalto": {type:"string", required:false}
                    "option socket-stats": {type:"string", required:false}
                    "option splice-auto": {type:"string", required:false}
                    "option splice-request": {type:"string", required:false}
                    "option splice-response": {type:"string", required:false}
                    "option tcp-smart-accept": {type:"string", required:false}
                    "option tcp-smart-connect": {type:"string", required:false}
                    "option tcpka": {type:"string", required:false}
                    "option tcplog": {type:"string", required:false}
                    "rate-limit sessions": {type:"string", required:false}
                    "redirect": {type:"string", required:false}
                    "reqadd": {type:"string", required:false}
                    "reqallow": {type:"string", required:false}
                    "reqdel": {type:"string", required:false}
                    "reqdeny": {type:"string", required:false}
                    "reqiallow": {type:"string", required:false}
                    "reqidel": {type:"string", required:false}
                    "reqideny": {type:"string", required:false}
                    "reqipass": {type:"string", required:false}
                    "reqirep": {type:"string", required:false}
                    "reqitarpit": {type:"string", required:false}
                    "reqpass": {type:"string", required:false}
                    "reqrep": {type:"string", required:false}
                    "reqtarpit": {type:"string", required:false}
                    "rspadd": {type:"string", required:false}
                    "rspdel": {type:"string", required:false}
                    "rspdeny": {type:"string", required:false}
                    "rspidel": {type:"string", required:false}
                    "rspideny": {type:"string", required:false}
                    "rspirep": {type:"string", required:false}
                    "rsprep": {type:"string", required:false}
                    "stats admin": {type:"string", required:false}
                    "stats auth": {type:"string", required:false}
                    "stats enable": {type:"string", required:false}
                    "stats hide-version": {type:"string", required:false}
                    "stats http-request": {type:"string", required:false}
                    "stats realm": {type:"string", required:false}
                    "stats refresh": {type:"string", required:false}
                    "stats scope": {type:"string", required:false}
                    "stats show-desc": {type:"string", required:false}
                    "stats show-legends": {type:"string", required:false}
                    "stats show-node": {type:"string", required:false}
                    "stats uri": {type:"string", required:false}
                    "tcp-request connection": {type:"string", required:false}
                    "tcp-request content": {type:"string", required:false}
                    "tcp-request inspect-delay": {type:"string", required:false}
                    "timeout client": {type:"string", required:false}
                    "timeout client-fin": {type:"string", required:false}
                    "timeout clitimeout": {type:"string", required:false}
                    "timeout http-keep-alive": {type:"string", required:false}
                    "timeout http-request": {type:"string", required:false}
                    "timeout tarpit": {type:"string", required:false}
                    "unique-id-format": {type:"string", required:false}
                    "unique-id-header": {type:"string", required:false}
                    "use_backend": items: {type:"object", required:false}


        "backend":
            type: "array"
            items:
                name: "backend"
                type: "object"
                required: false                        
                properties:
                    "name": {type:"string", required:false}     
                    "balance": {type:"string", required:false}
                    "acl": {type:"string", required:false}
                    "bind-process": {type:"string", required:false}
                    "block": {type:"string", required:false}
                    "compression": {type:"string", required:false}
                    "contimeout": {type:"string", required:false}
                    "cookie": items: {type:"string", required:false}
                    "default-server": {type:"string", required:false}
                    "description": {type:"string", required:false}
                    "disabled": {type:"string", required:false}
                    "dispatch": {type:"string", required:false}
                    "email-alert from": {type:"string", required:false}
                    "email-alert level": {type:"string", required:false}
                    "email-alert mailers": {type:"string", required:false}
                    "email-alert myhostname": {type:"string", required:false}
                    "email-alert to": {type:"string", required:false}
                    "enabled": {type:"string", required:false}
                    "errorfile": {type:"string", required:false}
                    "errorloc": {type:"string", required:false}
                    "errorloc303": {type:"string", required:false}
                    "force-persist": {type:"string", required:false}
                    "fullconn": {type:"string", required:false}
                    "grace": {type:"string", required:false}
                    "hash-type": {type:"string", required:false}
                    "http-check disable-on-404": {type:"string", required:false}
                    "http-check expect": {type:"string", required:false}
                    "http-check send-state": {type:"string", required:false}
                    "http-request": {type:"string", required:false}
                    "http-response": {type:"string", required:false}
                    "http-reuse": {type:"string", required:false}
                    "http-send-name-header": {type:"string", required:false}
                    "id": {type:"string", required:false}
                    "ignore-persist": {type:"string", required:false}
                    "load-server-state-from-file": {type:"string", required:false}
                    "log": {type:"string", required:false}
                    "log-tag": {type:"string", required:false}
                    "max-keep-alive-queue": {type:"string", required:false}
                    "mode": {type:"string", required:false}
                    "option": items: {type:"string", required:false}
                    "option abortonclose": {type:"string", required:false}
                    "option accept-invalid-http-response": {type:"string", required:false}
                    "option allbackups": {type:"string", required:false}
                    "option checkcache": {type:"string", required:false}
                    "option forceclose": {type:"string", required:false}
                    "option forwardfor": {type:"string", required:false}
                    "option http-buffer-request": {type:"string", required:false}
                    "option http-keep-alive": {type:"string", required:false}
                    "option http-no-delay": {type:"string", required:false}
                    "option http-pretend-keepalive": {type:"string", required:false}
                    "option http-server-close": {type:"string", required:false}
                    "option http-tunnel": {type:"string", required:false}
                    "option httpchk": {type:"string", required:false}
                    "option httpclose": {type:"string", required:false}
                    "option httplog": {type:"string", required:false}
                    "option http_proxy": {type:"string", required:false}
                    "option independent-streams": {type:"string", required:false}
                    "option ldap-check": {type:"string", required:false}
                    "option external-check": {type:"string", required:false}
                    "option log-health-checks": {type:"string", required:false}
                    "option mysql-check": {type:"string", required:false}
                    "option nolinger": {type:"string", required:false}
                    "option originalto": {type:"string", required:false}
                    "option persist": {type:"string", required:false}
                    "option pgsql-check": {type:"string", required:false}
                    "option prefer-last-server": {type:"string", required:false}
                    "option redispatch": {type:"string", required:false}
                    "option redis-check": {type:"string", required:false}
                    "option smtpchk": {type:"string", required:false}
                    "option splice-auto": {type:"string", required:false}
                    "option splice-request": {type:"string", required:false}
                    "option splice-response": {type:"string", required:false}
                    "option srvtcpka": {type:"string", required:false}
                    "option ssl-hello-chk": {type:"string", required:false}
                    "option tcp-check": {type:"string", required:false}
                    "option tcp-smart-connect": {type:"string", required:false}
                    "option tcpka": {type:"string", required:false}
                    "option tcplog": {type:"string", required:false}
                    "option transparent": {type:"string", required:false}
                    "external-check command": {type:"string", required:false}
                    "external-check path": {type:"string", required:false}
                    "persist rdp-cookie": {type:"string", required:false}
                    "redirect": {type:"string", required:false}
                    "redisp": {type:"string", required:false}
                    "redispatch": {type:"string", required:false}
                    "reqadd": {type:"string", required:false}
                    "reqallow": {type:"string", required:false}
                    "reqdel": {type:"string", required:false}
                    "reqdeny": {type:"string", required:false}
                    "reqiallow": {type:"string", required:false}
                    "reqidel": {type:"string", required:false}
                    "reqideny": {type:"string", required:false}
                    "reqipass": {type:"string", required:false}
                    "reqirep": {type:"string", required:false}
                    "reqitarpit": {type:"string", required:false}
                    "reqpass": {type:"string", required:false}
                    "reqrep": {type:"string", required:false}
                    "reqtarpit": {type:"string", required:false}
                    "retries": {type:"string", required:false}
                    "rspadd": {type:"string", required:false}
                    "rspdel": {type:"string", required:false}
                    "rspdeny": {type:"string", required:false}
                    "rspidel": {type:"string", required:false}
                    "rspideny": {type:"string", required:false}
                    "rspirep": {type:"string", required:false}
                    "rsprep": {type:"string", required:false}
                    "server": items: {type:"object", required:false}
                    "server-state-file-name": {type:"string", required:false}
                    "source": {type:"string", required:false}
                    "srvtimeout": {type:"string", required:false}
                    "stats admin": {type:"string", required:false}
                    "stats auth": {type:"string", required:false}
                    "stats enable": {type:"string", required:false}
                    "stats hide-version": {type:"string", required:false}
                    "stats http-request": {type:"string", required:false}
                    "stats realm": {type:"string", required:false}
                    "stats refresh": {type:"string", required:false}
                    "stats scope": {type:"string", required:false}
                    "stats show-desc": {type:"string", required:false}
                    "stats show-legends": {type:"string", required:false}
                    "stats show-node": {type:"string", required:false}
                    "stats uri": {type:"string", required:false}
                    "stick match": {type:"string", required:false}
                    "stick on": {type:"string", required:false}
                    "stick store-request": {type:"string", required:false}
                    "stick store-response": {type:"string", required:false}
                    "stick-table": {type:"string", required:false}
                    "tcp-check connect": {type:"string", required:false}
                    "tcp-check expect": {type:"string", required:false}
                    "tcp-check send": {type:"string", required:false}
                    "tcp-check send-binary": {type:"string", required:false}
                    "tcp-request content": {type:"string", required:false}
                    "tcp-request inspect-delay": {type:"string", required:false}
                    "tcp-response content": {type:"string", required:false}
                    "tcp-response inspect-delay": {type:"string", required:false}
                    "timeout check": {type:"string", required:false}
                    "timeout connect": {type:"string", required:false}
                    "timeout contimeout": {type:"string", required:false}
                    "timeout http-keep-alive": {type:"string", required:false}
                    "timeout http-request": {type:"string", required:false}
                    "timeout queue": {type:"string", required:false}
                    "timeout server": {type:"string", required:false}
                    "timeout server-fin": {type:"string", required:false}
                    "timeout srvtimeout": {type:"string", required:false}
                    "timeout tarpit": {type:"string", required:false}
                    "timeout tunnel": {type:"string", required:false}
                    "transparent": {type:"string", required:false}
                    "use-server": {type:"string", required:false}


module.exports = schema_haproxy
