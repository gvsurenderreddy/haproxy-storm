jsonfile = require('jsonfile')
Start = require('./../src/context').start
Stop = require('./../src/context').stop
Update = require('./../src/context').update
Validate = require('./../src/context').validate
Promise = require 'bluebird'
diff = require('deep-diff').diff
utils = require('utils')._

# haproxy-storm context data for default and custom configurations 
#---------------------------------------------------------------------------------------------

context = {
	"baseUrl": "http://192.168.122.146:5000",
	"bInstalledPackages": true,
	"bFactoryPush": false,
	"service": {
		"name": "haproxy",
		"factoryConfig": {
			"config": {

				"global": {

					"log": [
						["localhost local0"],
						["localhost local1 notice"]
					],
					"daemon": "",
					"uid": "200",
					"gid": "200",
					"maxconn": "10000",
					"stats": [{
						"socket": "/var/run/haproxy.stat",
						"mode": "600",
						"level": "admin"
					}]
				},
				"peers": [{
					"name": "mypeers",
					"peer": [{
						"servername": "haproxy1",
						"serverIP": "192.168.122.1",
						"port": "8089"
					}, {
						"servername": "haproxy1",
						"serverIP": "192.168.122.1",
						"port": "80810"
					}]
				}],
				"mailers": [{
					"name": "mymailers",
					"mailer": [{
						"servername": "smtp1",
						"serverIP": "192.168.122.1",
						"port": "8089"
					}, {
						"servername": "smtp2",
						"serverIP": "192.168.122.1",
						"port": "80810"
					}]
				}],
				"frontend": [{
					"name": "public",
					"bind": [{
						"servername": "192.168.122.146",
						"port": "8080",
						"options": "name clear"
					}],
					"mode": "http",
					"log": "global",
					"option httplog": "",
					"option dontlognull": "",
					"monitor-uri": "/monitoruri",
					"maxconn": "8000",
					"timeout client": "30s",
					"reqadd": "X-Forwarded-Proto:\\ http",
					"stick-table": " type ip size 100k expire 30s store conn_cur",
					"tcp-request connection": [
						["accept if { src -f /etc/haproxy/whitelist.lst }"],
						["reject if { src_conn_cur ge 10 }"],
						["track-sc1 src"]
					],
					"stats uri": "/admin/stats",
					"use_backend": [{
						"static": ["if { hdr_beg(host) -i img }",
							"if { path_beg /img /css   }"
						]
					}],
					"default_backend": "clearpathpool"

				}],
				"backend": [{
					"name": "clearpathpool",
					"mode": "http",
					"balance": "roundrobin",
					"retries": "2",
					"option": "redispatch",
					"timeout connect": "5s",
					"timeout server ": "30s",
					"timeout queue ": "30s",

					"option httpchk": "HEAD /login.php",
					"cookie": ["DYNSRV", "insert", "indirect", "nocache"],
					"fullconn": "4000",
					"server": [{
						"servername": "clearpathserv1",
						"serverIP": "192.168.122.1",
						"port": "8081",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv2",
						"serverIP": "192.168.122.1",
						"port": "8082",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}]
				}, {
					"name": "static",
					"mode": "http",
					"balance": "roundrobin",
					"retries": "2",
					"option": "redispatch",
					"timeout connect": "5s",
					"timeout server ": "30s",
					"timeout queue ": "30s",
					"option httpchk": "HEAD /index.html",
					"cookie": ["DYNSRV", "insert", "indirect", "nocache"],
					"fullconn": "4000",
					"server": [{
						"servername": "clearpathserv9",
						"serverIP": "192.168.122.1",
						"port": "8089",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv10",
						"serverIP": "192.168.122.1",
						"port": "80810",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}]
				}]
			}
		},
		"policyConfig": {
			"config": {
				"global": {

					"log": [
						["localhost local0"],
						["localhost local1 notice"]
					],
					"daemon": "",
					"uid": "200",
					"gid": "200",
					"maxconn": "10000",
					"stats": [{
						"socket": "/var/run/haproxy.stat",
						"mode": "600",
						"level": "admin"
					}]
				},
				"peers": [{
					"name": "mypeers",
					"peer": [{
						"servername": "haproxy1",
						"serverIP": "192.168.122.1",
						"port": "8089"
					}, {
						"servername": "haproxy1",
						"serverIP": "192.168.122.1",
						"port": "80810"
					}]
				}],
				"mailers": [{
					"name": "mymailers",
					"mailer": [{
						"servername": "smtp1",
						"serverIP": "192.168.122.1",
						"port": "8089"
					}, {
						"servername": "smtp2",
						"serverIP": "192.168.122.1",
						"port": "80810"
					}]
				}],
				"frontend": [{
					"name": "public",
					"bind": [{
						"servername": "192.168.122.146",
						"port": "8080",
						"options": "name clear"
					}],
					"mode": "http",
					"log": "global",
					"option httplog": "",
					"option dontlognull": "",
					"monitor-uri": "/monitoruri",
					"maxconn": "8000",
					"timeout client": "30s",
					"reqadd": "X-Forwarded-Proto:\\ http",
					"stick-table": " type ip size 100k expire 30s store conn_cur",
					"tcp-request connection": [
						["accept if { src -f /etc/haproxy/whitelist.lst }"],
						["reject if { src_conn_cur ge 10 }"],
						["track-sc1 src"]
					],
					"stats uri": "/admin/stats",
					"use_backend": [{
						"static": ["if { hdr_beg(host) -i img }",
							"if { path_beg /img /css   }"
						]
					}],
					"default_backend": "clearpathpool"

				}],
				"backend": [{
					"name": "clearpathpool",
					"mode": "http",
					"balance": "roundrobin",
					"retries": "2",
					"option": "redispatch",
					"timeout connect": "5s",
					"timeout server ": "30s",
					"timeout queue ": "30s",

					"option httpchk": "HEAD /login.php",
					"cookie": ["DYNSRV", "insert", "indirect", "nocache"],
					"fullconn": "4000",
					"server": [{
						"servername": "clearpathserv1",
						"serverIP": "192.168.122.1",
						"port": "8081",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv2",
						"serverIP": "192.168.122.1",
						"port": "8082",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv3",
						"serverIP": "192.168.122.1",
						"port": "8083",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv4",
						"serverIP": "192.168.122.1",
						"port": "8084",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv5",
						"serverIP": "192.168.122.1",
						"port": "8085",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv6",
						"serverIP": "192.168.122.1",
						"port": "8086",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv7",
						"serverIP": "192.168.122.1",
						"port": "8087",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv8",
						"serverIP": "192.168.122.1",
						"port": "8088",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}]
				}, {
					"name": "static",
					"mode": "http",
					"balance": "roundrobin",
					"retries": "2",
					"option": "redispatch",
					"timeout connect": "5s",
					"timeout server ": "30s",
					"timeout queue ": "30s",
					"option httpchk": "HEAD /index.html",
					"cookie": ["DYNSRV", "insert", "indirect", "nocache"],
					"fullconn": "4000",
					"server": [{
						"servername": "clearpathserv9",
						"serverIP": "192.168.122.1",
						"port": "8089",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}, {
						"servername": "clearpathserv10",
						"serverIP": "192.168.122.1",
						"port": "80810",
						"minconn": "50",
						"maxconn": "500",
						"cookie": "s1",
						"check ": "",
						"inter": "1000"
					}]
				}]
			}
		}
	}
}



getPromise = ->
    return new Promise (resolve, reject) ->
        resolve()

startcall = (context)->
    getPromise()
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/start-input.json",context,{spaces: 2})
        return Start context
    .catch (err) =>
        console.log "Start err ", err
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/start-output.json",resp,{spaces: 2})
        context = {}
        context = utils.extend {},resp
        console.log "HAProxy Start done for instance: ", context.instance
    .done

stopcall = (context)->
    getPromise()
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/stop-input.json",context,{spaces: 2})
        return Stop context
    .catch (err) =>
        console.log "Stop err ", err
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/stop-output.json",resp,{spaces: 2})
        context = {}
        context = utils.extend {},resp
        console.log "HAProxy Stop done"
    .done

updatecall = (context)->
    getPromise()
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/update-input.json",context,{spaces: 2})
        return Update context
    .catch (err) =>
        console.log "Update err ", err
    .then (resp) =>
        jsonfile.writeFileSync("/tmp/update-output.json",resp,{spaces: 2})
        context = {}
        context = utils.extend {},resp
        console.log "HAProxy Update done for instance: ", resp.instance
    .done

startcall(context);
setTimeout(updatecall, 20000, context);
setTimeout(stopcall, 40000, context);
setTimeout(startcall, 60000, context);
setTimeout(updatecall, 80000, context);
setTimeout(stopcall, 100000, context);
