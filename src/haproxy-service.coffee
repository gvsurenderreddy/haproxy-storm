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
            service: filename:"#{@configPath}/haproxy_#{@id}.conf"
         
        @invocation = merge @invocation,
            args: ["-f #{@configs.service.filename}"]
            options: { stdio: ["ignore", @out, @err] }

        @configs.service.generator = (callback) =>         
            haproxyconfig = ""
            for key, val of @data
                switch (key)
                    when "global"             
                        haproxyconfig += 'global'+ "\n"      
                        for keyy,value of val
                            switch (typeof value)
                                when "string","number"
                                    haproxyconfig += ' ' + keyy + ' ' + value + "\n"
                                when "object"
                                    haproxyconfig += "\n" #not supported
                    when "frontend"
                        for frontents in frontend
                            for keyy,value of val
                                switch (typeof value)
                                    when "string","number"
                                        haproxyconfig += 'frontends' + ' ' + value +"\n" if keyy is name
                                        haproxyconfig += ' ' + keyy + ' ' + value + "\n" unless keyy is name
                                    when "object"
                                        haproxyconfig += "\n" #not supported                        
                    when "backend"
                        haproxyconfig += ""                        
                    when "defaults"
                        haproxyconfig += "\n"
                    when "listen"
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
