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
        opts.configPath ?= "/var/stormflash/plugins/haproxy"
        opts.logPath ?= "/var/log/haproxy"

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
                    when "global","defaults"
                        haproxyconfig += key + "\n"
                        for keyy,value of val
                            switch (typeof value)
                                when "string","number"
                                    haproxyconfig += '    ' + keyy + ' ' + value + '\n'
                            if value instanceof Array
                                myarray = "yes"
                                for ival in value
                                  if ival instanceof Array
                                          haproxyconfig += '    ' + keyy
                                          for jval in ival
                                            haproxyconfig += ' ' + jval
                                          haproxyconfig += '\n'
                                  if ival not instanceof Array
                                      switch (typeof ival)
                                        when "string","number"
                                            haproxyconfig += '    ' + keyy + ' ' + ival  if myarray is "yes"
                                            haproxyconfig += ' ' + ival unless myarray is "yes"
                                            myarray = "no"
                                        when "object"
                                          haproxyconfig += '    ' + keyy
                                          for kkey,kval of ival
                                              haproxyconfig += ' ' + kkey + ' ' + kval
                                          haproxyconfig += '\n'
                                haproxyconfig += '\n'
                        haproxyconfig += '\n'
                    when "frontend"
                        for frontend in val
                            for keyy,value of frontend
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += key + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  myarray = "yes"
                                  for ival in value
                                    if ival not instanceof Array
                                      switch (typeof ival)
                                        when "string","number"
                                            haproxyconfig += '    ' + keyy + ' ' + ival  if myarray is "yes"
                                            haproxyconfig += ' ' + ival unless myarray is "yes"
                                            myarray = "no"
                                        when "object"
                                          if keyy isnt "bind" 
                                            if keyy isnt "use_backend"
                                              haproxyconfig += '    ' + keyy
                                              for kkey,kval of ival
                                                haproxyconfig += ' ' + kkey + ' ' + kval
                                              haproxyconfig += '\n'
                                          else
                                            haproxyconfig += '\n'
                                    if ival instanceof Array
                                        haproxyconfig += "    " + keyy
                                        for kval in ival
                                            haproxyconfig += " " + kval
                                        haproxyconfig += "\n"
                                    if keyy is "bind"
                                        haproxyconfig += "    " + keyy 
                                        for jkey,jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                when "options"
                                                    haproxyconfig += " " + jval
                                        haproxyconfig += "\n"
                                    if keyy is "use_backend"
                                        for jkey, jval of ival
                                            for kval in jval
                                                haproxyconfig += "    " + keyy + " " + jkey + " " +  kval + "\n"
                                    if key is "listen"
                                      if keyy is "server"
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
                            haproxyconfig += "\n"
                        haproxyconfig += '\n'
                    when "backend","listen"
                        for backend in val
                            for keyy,value of backend
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += key  + ' ' + value + '\n' if keyy is "name"
                                        haproxyconfig += '    ' + keyy + ' ' + value + '\n' unless keyy is "name"
                                    when "object"
                                        haproxyconfig += "\n" #not supported
                                if value instanceof Array
                                  myarray = "yes"
                                  for ival in value
                                    if ival instanceof Array
                                          haproxyconfig += "    " + keyy
                                          for jval in ival
                                            haproxyconfig += " " + jval
                                          haproxyconfig += "\n"
                                    if keyy is "server"
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
                                    if key is "listen"
                                      if keyy is "bind"
                                        haproxyconfig += "    " + keyy 
                                        for jkey,jval of ival
                                            switch (jkey)
                                                when "servername"
                                                    haproxyconfig += " " + jval
                                                when "port"
                                                    haproxyconfig += ":" + jval
                                                else
                                                    haproxyconfig += " " + jval
                                        haproxyconfig += "\n"
                                    if ival not instanceof Array
                                      switch (typeof ival)
                                        when "string","number"
                                            haproxyconfig += '    ' + keyy + ' ' + ival  if myarray is "yes"
                                            haproxyconfig += ' ' + ival unless myarray is "yes"
                                            myarray = "no"
                                        when "object"
                                          if keyy isnt "bind" 
                                            if keyy isnt "server"
                                              haproxyconfig += '    ' + keyy
                                              for kkey,kval of ival
                                                haproxyconfig += ' ' + kkey + ' ' + kval
                                              haproxyconfig += '\n'
                                          else
                                              haproxyconfig += '\n'
                                  haproxyconfig += "\n"
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
                            haproxyconfig += "\n"
                        haproxyconfig += "\n"
                    else
                        haproxyconfig += "\n"
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
