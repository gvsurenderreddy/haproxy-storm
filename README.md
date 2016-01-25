HAProxy-storm
===================

Synopsis
--------
HAProxy-storm is a storm plugin for managing the haproxy service.

It provides the REST API to configure the haproxy and manages the haproxy using stormflash framework. 
and also the haproxy process is monitored by the stormflash.


*List of APIs*
=============

<table>
  <tr>
    <th>Verb</th><th>URI</th><th>Description</th>
  </tr>
  <tr>
    <td>POST</td><td>/haproxy</td><td>Create haproxy configuration</td>
  </tr>
  <tr>
    <td>GET</td><td>/haproxy/:id</td><td>Describe haproxy configurations info of specific haproxy instance</td>
  </tr>
  <tr>
    <td>PUT</td><td>/haproxy/:id</td><td>Updates haproxy the configurations</td>
  </tr>
  <tr>
    <td>GET</td><td>/haproxy</td><td>Lists haproxy configurations of all instances</td>
  </tr>
  <tr>
    <td>DELETE</td><td>/haproxy/:id</td><td>Delete the haproxy instance configs and instance in container</td>
  </tr> 
</table>


**POST haproxy API**

    Verb      URI                  Description
    POST      /haproxy             Creates haproxy configuration and starts the haproxy process


**Example Request and Response**

### Request JSON


 {
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
	        "compression":[["algo","identity"],["type","text/html","text/plain","text/javascript","application/javascript"]],
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
 			"port": "9090",
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



### Response JSON


    {
        "id": "c0275c3e-fd9e-4bf9-a44c-fb120b811e0d",
        "running": true
    }


**GET /haproxy API**

    Verb    URI                        Description
    GET     /haproxy/:id               List the haproxy configs.


**Example Response**


    {
        "id": "c0275c3e-fd9e-4bf9-a44c-fb120b811e0d",
        "data":
        {
            "global":
            {
                "log":
                [
                    [
                        "localhost local0"
                    ],
                    [
                        "localhost local1 notice"
                    ]
                ],
                "daemon": "",
                "uid": "200",
                "gid": "200",
                "maxconn": "10000",
                "stats":
                [
                    {
                        "socket": "/var/run/haproxy.stat",
                        "mode": "600",
                        "level": "admin"
                    }
                ]
            },
            "peers":
            [
                {
                    "name": "mypeers",
                    "peer":
                    [
                        {
                            "servername": "haproxy1",
                            "serverIP": "192.168.122.1",
                            "port": "8089"
                        },
                        {
                            "servername": "haproxy1",
                            "serverIP": "192.168.122.1",
                            "port": "80810"
                        }
                    ]
                }
            ],
            "mailers":
            [
                {
                    "name": "mymailers",
                    "mailer":
                    [
                        {
                            "servername": "smtp1",
                            "serverIP": "192.168.122.1",
                            "port": "8089"
                        },
                        {
                            "servername": "smtp2",
                            "serverIP": "192.168.122.1",
                            "port": "80810"
                        }
                    ]
                }
            ],
            "frontend":
            [
                {
                    "name": "public",
                    "bind":
                    [
                        {
                            "servername": "192.168.122.146",
                            "port": "8080",
                            "options": "name clear"
                        }
                    ],
                    "mode": "http",
                    "log": "global",
                    "option httplog": "",
                    "option dontlognull": "",
                    "monitor-uri": "/monitoruri",
                    "maxconn": "8000",
                    "timeout client": "30s",
                    "reqadd": "X-Forwarded-Proto:\ http",
                    "stick-table": " type ip size 100k expire 30s store conn_cur",
                    "tcp-request connection":
                    [
                        [
                            "accept if { src -f /etc/haproxy/whitelist.lst }"
                        ],
                        [
                            "reject if { src_conn_cur ge 10 }"
                        ],
                        [
                            "track-sc1 src"
                        ]
                    ],
                    "compression":
                    [
                        [
                            "algo",
                            "identity"
                        ],
                        [
                            "type",
                            "text/html",
                            "text/plain",
                            "text/javascript",
                            "application/javascript"
                        ]
                    ],
                    "stats uri": "/admin/stats",
                    "use_backend":
                    [
                        {
                            "static":
                            [
                                "if { hdr_beg(host) -i img }",
                                "if { path_beg /img /css   }"
                            ]
                        }
                    ],
                    "default_backend": "clearpathpool"
                }
            ],
            "backend":
            [
                {
                    "name": "clearpathpool",
                    "mode": "http",
                    "balance": "roundrobin",
                    "retries": "2",
                    "option": "redispatch",
                    "timeout connect": "5s",
                    "timeout server ": "30s",
                    "timeout queue ": "30s",
                    "option httpchk": "HEAD /login.php",
                    "cookie":
                    [
                        "DYNSRV",
                        "insert",
                        "indirect",
                        "nocache"
                    ],
                    "fullconn": "4000",
                    "server":
                    [
                        {
                            "servername": "clearpathserv1",
                            "serverIP": "192.168.122.1",
                            "port": "9090",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv2",
                            "serverIP": "192.168.122.1",
                            "port": "9091",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv3",
                            "serverIP": "192.168.122.1",
                            "port": "9092",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv4",
                            "serverIP": "192.168.122.1",
                            "port": "9093",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv5",
                            "serverIP": "192.168.122.1",
                            "port": "8085",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv6",
                            "serverIP": "192.168.122.1",
                            "port": "8086",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv7",
                            "serverIP": "192.168.122.1",
                            "port": "8087",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv8",
                            "serverIP": "192.168.122.1",
                            "port": "8088",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        }
                    ]
                },
                {
                    "name": "static",
                    "mode": "http",
                    "balance": "roundrobin",
                    "retries": "2",
                    "option": "redispatch",
                    "timeout connect": "5s",
                    "timeout server ": "30s",
                    "timeout queue ": "30s",
                    "option httpchk": "HEAD /index.html",
                    "cookie":
                    [
                        "DYNSRV",
                        "insert",
                        "indirect",
                        "nocache"
                    ],
                    "fullconn": "4000",
                    "server":
                    [
                        {
                            "servername": "clearpathserv9",
                            "serverIP": "192.168.122.1",
                            "port": "8089",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv10",
                            "serverIP": "192.168.122.1",
                            "port": "80810",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        }
                    ]
                }
            ]
        },
        "saved": true,
        "isRunning": true,
        "_events":
        {
            "running":
            [
                null,
                null
            ]
        },
        "configPath": "/var/stormflash/plugins/haproxy",
        "logPath": "/var/log/haproxy",
        "out": 305,
        "err": 308,
        "configs":
        {
            "service":
            {
                "filename": "/var/stormflash/plugins/haproxy/c0275c3e-fd9e-4bf9-a44c-fb120b811e0d.conf"
            }
        },
        "invocation":
        {
            "name": "haproxy",
            "path": "/usr/sbin",
            "monitor": true,
            "args":
            [
                "-d",
                "-f",
                "/var/stormflash/plugins/haproxy/c0275c3e-fd9e-4bf9-a44c-fb120b811e0d.conf"
            ],
            "options":
            {
                "detached": true,
                "stdio":
                [
                    "ignore",
                    305,
                    308
                ]
            }
        },
        "isReady": true,
        "instance": 15657
    }


**GET on haproxy API**

    Verb    URI                  Description
    GET     /haproxy             Show haproxy configurations of all instances

**Example Request and Response**


### Response JSON

    [
    {
        "id": "c0275c3e-fd9e-4bf9-a44c-fb120b811e0d",
        "data":
        {
            "global":
            {
                "log":
                [
                    [
                        "localhost local0"
                    ],
                    [
                        "localhost local1 notice"
                    ]
                ],
                "daemon": "",
                "uid": "200",
                "gid": "200",
                "maxconn": "10000",
                "stats":
                [
                    {
                        "socket": "/var/run/haproxy.stat",
                        "mode": "600",
                        "level": "admin"
                    }
                ]
            },
            "peers":
            [
                {
                    "name": "mypeers",
                    "peer":
                    [
                        {
                            "servername": "haproxy1",
                            "serverIP": "192.168.122.1",
                            "port": "8089"
                        },
                        {
                            "servername": "haproxy1",
                            "serverIP": "192.168.122.1",
                            "port": "80810"
                        }
                    ]
                }
            ],
            "mailers":
            [
                {
                    "name": "mymailers",
                    "mailer":
                    [
                        {
                            "servername": "smtp1",
                            "serverIP": "192.168.122.1",
                            "port": "8089"
                        },
                        {
                            "servername": "smtp2",
                            "serverIP": "192.168.122.1",
                            "port": "80810"
                        }
                    ]
                }
            ],
            "frontend":
            [
                {
                    "name": "public",
                    "bind":
                    [
                        {
                            "servername": "192.168.122.146",
                            "port": "8080",
                            "options": "name clear"
                        }
                    ],
                    "mode": "http",
                    "log": "global",
                    "option httplog": "",
                    "option dontlognull": "",
                    "monitor-uri": "/monitoruri",
                    "maxconn": "8000",
                    "timeout client": "30s",
                    "reqadd": "X-Forwarded-Proto:\ http",
                    "stick-table": " type ip size 100k expire 30s store conn_cur",
                    "tcp-request connection":
                    [
                        [
                            "accept if { src -f /etc/haproxy/whitelist.lst }"
                        ],
                        [
                            "reject if { src_conn_cur ge 10 }"
                        ],
                        [
                            "track-sc1 src"
                        ]
                    ],
                    "compression":
                    [
                        [
                            "algo",
                            "identity"
                        ],
                        [
                            "type",
                            "text/html",
                            "text/plain",
                            "text/javascript",
                            "application/javascript"
                        ]
                    ],
                    "stats uri": "/admin/stats",
                    "use_backend":
                    [
                        {
                            "static":
                            [
                                "if { hdr_beg(host) -i img }",
                                "if { path_beg /img /css   }"
                            ]
                        }
                    ],
                    "default_backend": "clearpathpool"
                }
            ],
            "backend":
            [
                {
                    "name": "clearpathpool",
                    "mode": "http",
                    "balance": "roundrobin",
                    "retries": "2",
                    "option": "redispatch",
                    "timeout connect": "5s",
                    "timeout server ": "30s",
                    "timeout queue ": "30s",
                    "option httpchk": "HEAD /login.php",
                    "cookie":
                    [
                        "DYNSRV",
                        "insert",
                        "indirect",
                        "nocache"
                    ],
                    "fullconn": "4000",
                    "server":
                    [
                        {
                            "servername": "clearpathserv1",
                            "serverIP": "192.168.122.1",
                            "port": "9090",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv2",
                            "serverIP": "192.168.122.1",
                            "port": "9091",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv3",
                            "serverIP": "192.168.122.1",
                            "port": "9092",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv4",
                            "serverIP": "192.168.122.1",
                            "port": "9093",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv5",
                            "serverIP": "192.168.122.1",
                            "port": "8085",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv6",
                            "serverIP": "192.168.122.1",
                            "port": "8086",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv7",
                            "serverIP": "192.168.122.1",
                            "port": "8087",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv8",
                            "serverIP": "192.168.122.1",
                            "port": "8088",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        }
                    ]
                },
                {
                    "name": "static",
                    "mode": "http",
                    "balance": "roundrobin",
                    "retries": "2",
                    "option": "redispatch",
                    "timeout connect": "5s",
                    "timeout server ": "30s",
                    "timeout queue ": "30s",
                    "option httpchk": "HEAD /index.html",
                    "cookie":
                    [
                        "DYNSRV",
                        "insert",
                        "indirect",
                        "nocache"
                    ],
                    "fullconn": "4000",
                    "server":
                    [
                        {
                            "servername": "clearpathserv9",
                            "serverIP": "192.168.122.1",
                            "port": "8089",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        },
                        {
                            "servername": "clearpathserv10",
                            "serverIP": "192.168.122.1",
                            "port": "80810",
                            "minconn": "50",
                            "maxconn": "500",
                            "cookie": "s1",
                            "check ": "",
                            "inter": "1000"
                        }
                    ]
                }
            ]
        },
        "saved": true,
        "isRunning": true,
        "_events":
        {
            "running":
            [
                null,
                null
            ]
        },
        "configPath": "/var/stormflash/plugins/haproxy",
        "logPath": "/var/log/haproxy",
        "out": 305,
        "err": 308,
        "configs":
        {
            "service":
            {
                "filename": "/var/stormflash/plugins/haproxy/c0275c3e-fd9e-4bf9-a44c-fb120b811e0d.conf"
            }
        },
        "invocation":
        {
            "name": "haproxy",
            "path": "/usr/sbin",
            "monitor": true,
            "args":
            [
                "-d",
                "-f",
                "/var/stormflash/plugins/haproxy/c0275c3e-fd9e-4bf9-a44c-fb120b811e0d.conf"
            ],
            "options":
            {
                "detached": true,
                "stdio":
                [
                    "ignore",
                    305,
                    308
                ]
            }
        },
        "isReady": true,
        "instance": 15657
    }
    ]


**PUT haproxy API**

    Verb    URI                        Description
    PUT     /haproxy/:id               Add multiple custom haproxy configs updates.


**Example Request and Response**

### Request JSON

 {
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
	        "compression":[["algo","identity"],["type","text/html","text/plain","text/javascript","application/javascript"]],
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
 			"port": "9090",
 			"minconn": "50",
 			"maxconn": "500",
 			"cookie": "s1",
 			"check ": "",
 			"inter": "1000"
 		}, {
 			"servername": "clearpathserv2",
 			"serverIP": "192.168.122.1",
 			"port": "9091",
 			"minconn": "50",
 			"maxconn": "500",
 			"cookie": "s1",
 			"check ": "",
 			"inter": "1000"
 		}, {
 			"servername": "clearpathserv3",
 			"serverIP": "192.168.122.1",
 			"port": "9092",
 			"minconn": "50",
 			"maxconn": "500",
 			"cookie": "s1",
 			"check ": "",
 			"inter": "1000"
 		}, {
 			"servername": "clearpathserv4",
 			"serverIP": "192.168.122.1",
 			"port": "9093",
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


### Response JSON

    {
        "updated": true
    }


**DELETE haproxy API**

    Verb    URI                                  Description
    DELETE  /haproxy/:id                         Delete the haproxy configurations and instances


**Example Request and Response**

### Response JSON

    Status Code: 204 No Content




Copyright & License
--------
LICENSE

MIT

COPYRIGHT AND PERMISSION NOTICE

Copyright (c) 2014-2015, Clearpath Networks, <licensing@clearpathnet.com>.

All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
