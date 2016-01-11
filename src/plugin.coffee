HAProxyService = require './haproxy-service'
HAProxyRegistry = require './haproxy-registry'

@include = ->
    agent = @settings.agent
    unless agent?
        throw  new Error "this plugin requires to be running in the context of a valid StormAgent!"

    plugindir = @settings.plugindir
    plugindir ?= "/var/stormflash/plugins/HAProxy"

    registry = new HAProxyRegistry plugindir+"/HAProxy.db"    
    registry.on 'ready', ->
        for service in @list()
            continue unless service instanceof HAProxyService
            agent.log "restore: trying to recover:", service

            do (service) -> service.generate (err) ->
                if err?
                    return agent.log "restore: HAProxy #{service.id} failed to generate configs!"
 

    @post '/HAProxy': ->
        try
            service = new HAProxyService null, @body, {}
        catch err
            return @next err
            
        service.generate (err, results) =>
            return @next err if err?
            agent.log "POST /HAProxy generation results " +  JSON.stringify results
            registry.add service
            agent.invoke service, (err, instance) =>
                if err?
                    #zregistry.remove zservice.id
                    return @next err
                else
                    @send {id: service.id, running: true}
    
    @put '/HAProxy/:id': ->
        service = registry.get @params.id
        unless service?
            @send 404
        else
            service.update @body, (result) =>
                @send result

    @get '/HAProxy': ->
         @send registry.list()

    @get '/HAProxy/:id': ->
        service = registry.get @params.id
        unless service?
            @send 404
        else
            @send service
    
    @del '/HAProxy/:id': ->
        service = registry.get @params.id
        return @send 404 unless service?

        registry.remove @params.id
        @send 204