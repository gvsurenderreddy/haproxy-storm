StormService = require('stormservice')
merge = require('fmerge')
fs = require 'fs'


class HAProxyService extends StormService
   
    invocation:
        name: 'haproxy'
        path: '/usr/sbin'
        monitor: true
        args: []
        options:
            detached: true
            stdio: ["ignore", -1, -1]


    constructor: (id, data, opts) ->
        if data.instance?
            @instance = data.instance
            delete data.instance

        opts ?= {}
        opts.configPath ?= "/var/stormflash/plugins/HAProxy"
        opts.logPath ?= "/var/log/HAProxy"

        super id, data, opts

        @configs =
            service: filename:"#{@configPath}/#{@id}.conf"

        @invocation = merge @invocation,
            args: ["-d","-f", "#{@configs.service.filename}"]
            options: { stdio: ["ignore", @out, @err] }

        @configs.service.generator = (callback) =>
            haproxyconfig = ""
            for key, val of @data
                switch (key)
                    when "global"
                        haproxyconfig += 'global'+ "\n"
                        for keyy,value of val
#                            switch (typeof value)
#                                when "string","number"
#                                    haproxyconfig += '    ' + keyy + ' ' + value + '\n'
#                                    haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
#                                    haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
#                                when "object"
#                                    haproxyconfig += "\n" #not supported
                            if value instanceof Array
                                #if keyy is "log"
                                for jval in value
                                  switch (typeof jval)
                                    when "string", "number"
                                        haproxyconfig += '    ' + keyy + ' ' + jval + '\n'
                                    when "object"
                                      haproxyconfig += '    ' + keyy
                                      for ikey,ival of jval
                                          haproxyconfig += ' ' + ikey + ' ' + ival
                                      haproxyconfig += '\n'
                                ###
                                if keyy is "stats"
                                    haproxyconfig += '    ' + keyy
                                    for val in value
                                        for ikey,ival of val
                                           haproxyconfig += ' ' + ikey + ' ' + ival
                                        haproxyconfig += '\n'
                                ###
                            else
                                haproxyconfig += '    ' + keyy + ' ' + value + '\n'
                        haproxyconfig += '\n\n'
                    when "frontend"
                        for frontend in val
                            for keyy,value of frontend
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += 'frontend' + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  if keyy is "tcp-request connection"
                                    for tcpconnval in value
                                        haproxyconfig += '    ' + keyy + ' ' + tcpconnval + '\n'
                                  if keyy is "bind"
                                    haproxyconfig += "    " + keyy 
                                    for ival in value
                                        for jkey,jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                when "options"
                                                    haproxyconfig += " " + jval + "\n"
                                  if keyy is "use_backend"
                                    for ival in value
                                        for jkey, jval of ival
                                            for kval in jval
                                                haproxyconfig += "    " + keyy + " " + jkey + " " +  kval + "\n"
#                                else
#                                    haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
                        haproxyconfig += '\n\n'
                    when "backend"
                        for backend in val
                            for keyy,value of backend
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += 'backend' + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  if keyy is "cookie"
                                      haproxyconfig += "    " + keyy
                                      for ival in value
                                          haproxyconfig += " " + ival
                                      haproxyconfig += "\n"
                                  if keyy is "server"
                                    for ival in value
                                        haproxyconfig += "    " + keyy
                                        for jkey, jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "serverIP"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                else
                                                    haproxyconfig += " " + jkey + " " + jval
                                        haproxyconfig += "\n"
#                                else
#                                    haproxyconfig += ' ' + keyy + ' ' + value + '\n'

                        haproxyconfig += "\n\n"
                    when "defaults"
                        haproxyconfig += 'defaults'+ "\n"
                        for keyy,value of val
                            switch (typeof value)
                                when "string","number"
                                    haproxyconfig += ' ' + keyy + ' ' + value + '\n'
                                when "object"
                                    haproxyconfig += "\n" #not supported
                            if value instanceof Array
                                if keyy is "log"
                                    for val in value
                                        haproxyconfig += ' ' + keyy + ' ' + val + '\n'
                                if keyy is "stats"
                                    haproxyconfig += ' ' + keyy
                                    for ikey, ival in value
                                        haproxyconfig += ' ' + ikey + ' ' + ival
                                    haproxyconfig += "\n"
                                if keyy is "use_backend"
                                    for ival in value
                                        for jkey, jval of ival
                                            for kval in jval
                                                haproxyconfig += " " + keyy + " " + jkey + " " +  kval + "\n"
                                if keyy is "bind"
                                    haproxyconfig += " " + keyy 
                                    for ival in value
                                        for jkey, jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                when "options"
                                                    haproxyconfig += " " + jval + "\n"
                        haproxyconfig += "\n\n"
                    when "peers","mailers"
                        for peers in val
                            for keyy,value of peers
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += key + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += ' ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  if keyy is "peer" or "mailer"
                                    for ival in value
                                        haproxyconfig += "    " + keyy
                                        for jkey, jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "serverIP"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                else
                                                    haproxyconfig += " " + jkey + " " + jval
                                        haproxyconfig += "\n"
                                    haproxyconfig += "\n"
                    when "userlist"
                        for userlist in val
                            for keyy,value of userlist
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += 'userlist' + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += ' ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  if keyy is "user" or "group"
                                    for ival in value
                                            haproxyconfig += "    " + keyy
                                            for kval in ival
                                                haproxyconfig += " " + kval
                                            haproxyconfig += "\n"
                                    haproxyconfig += "\n"
                    when "listen"
                        for listen in val
                            for keyy,value of listen
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += 'listen' + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += ' ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  if keyy is "bind"
                                    haproxyconfig += " " + keyy 
                                    for ival in value
                                        for jkey, jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                when "options"
                                                    haproxyconfig += " " + jval + "\n"
                                if keyy is "use_backend"
                                    for ival in value
                                        for jkey, jval of ival
                                            for kval in jval
                                                haproxyconfig += " " + keyy + " " + jkey + " " +  kval + "\n"
                        haproxyconfig += "\n\n"
                    else
                        haproxyconfig += ""
            callback haproxyconfig



    update: (newconfig, callback) ->
        @data = newconfig
        @generate callback


    destructor: ->
        @eliminate()
        #@out.close()
        #@err.close()
        @emit 'destroy'

module.exports = HAProxyService
