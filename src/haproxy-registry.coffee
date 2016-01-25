StormRegistry = require 'stormregistry'
StormData = require 'stormdata'

HAProxyService = require './haproxy-service'

class HAProxyRegistry extends StormRegistry
    constructor: (filename) ->
        @on 'load', (key,val) ->
            console.log "restoring #{key} with:",val
            entry = new HAProxyService key,val
            if entry?
                entry.saved = true
                @add entry

        @on 'removed', (entry) ->
            # an entry is removed in Registry
            entry.destructor() if entry.destructor?

        super filename

    add: (service) ->
        return unless service instanceof HAProxyService
        entry = super service.id, service
        # register for 'running' events of this service and update DB
        entry.on "running", (instance) =>
            if entry.instance isnt instance
                entry.instance = instance
                @update entry

    update: (service) ->
        service.data.instance = service.instance
        super service.id, service
        delete service.data.instance

    list : () ->
        results = []
        result = {}
        services = super
        for service in services
            result = service.data
            result.id = service.id
            results.push result
        results

module.exports  = HAProxyRegistry

