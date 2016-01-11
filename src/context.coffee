validate = require('json-schema').validate
assert = require 'assert'
Promise = require 'bluebird'
needle = Promise.promisifyAll(require('needle'))
utils = require('utils')._
diff = require('deep-diff').diff

schema_HAProxy = require('./schema')

getPromise = ->
    return new Promise (resolve, reject) ->
        resolve()


removeItem = (list,id)->
    console.log "remove item"
    console.log list
    console.log id
    itr = 0
    for item in list
        if item? and (item is id)
            index = itr
            break
        itr++
    console.log "iterator is ",itr
    console.log "index is", index
    delete list[index]
    list[index] = null


PostServer = (baseUrl,config)->
    needle.postAsync baseUrl + "/HAProxy", config, json:true
    .then (resp) =>
        console.log "statuscode: ", resp[0].statusCode
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 200
        return resp[1].id 
    .catch (err) =>
        throw err

DeleteServer = (baseUrl,instanceid)->
    needle.deleteAsync baseUrl + "/HAProxy/#{instanceid}", json:true
    .then (resp) =>
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 204
        return instanceid
    .catch (err) =>
        throw err

PutServer = (baseUrl,config,instanceid)->
    needle.putAsync baseUrl + "/HAProxy/#{instanceid}", config, json:true
    .then (resp) =>
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 200
        #server.history.config = utils.extend {},server.config
        return config
    .catch (err) =>
        throw err


Start =  (context) ->
    throw new Error 'HAProxy-storm.Start missingParams' unless context.bInstalledPackages and context.service.name

    if context.instances? and context.instances?.length > 0
        return context
    context.instances ?= []
    configObj = context.service.factoryConfig?.config
    config = configObj[context.service.name]    

    getPromise()
    .then (resp) =>        
        return PostServer(context.baseUrl,config)    
    .then (resp) =>
        console.log resp
        context.instances.push resp
        return context
    .catch (err) =>
        throw err


Stop =  (context) ->
    #throw new Error 'HAProxy-storm.Stop missingParams' unless context.bInstalledPackages and context.service.name
    #configObj = context.service.factoryConfig?.config
    #config = configObj[context.service.name]    
    throw new Error 'HAProxy-storm.Stop missingParams' unless context.instances and context.instances?.length > 0
    instances = context.instances 
    getPromise()
    .then (resp) =>     
        return DeleteServer(context.baseUrl,instances[0])    
    .then (resp) =>
        #console.log resp
        removeItem instances,resp
        return context
    .catch (err) =>
        throw err

Update =  (context) ->
    throw new Error 'HAProxy-storm.Stop missingParams' unless context.bInstalledPackages and context.service.name and context.policyConfig
    configObj = context.policyConfig
    config = configObj[context.service.name]           
    throw new Error 'config is missing' if utils.isEmpty(config)
    throw new Error 'Instance not found' unless context.instances? or not utils.isEmpty(context.instances) or context.instances[0] isnt null
    instance = context.instances[0]
    
    getPromise()
    .then (resp) =>       
        return PutServer(context.baseUrl,config,instance)    
    .then (resp) =>
        #console.log resp
        return context
    .catch (err) =>
        throw err


#input to the validate is  { config:{}}
Validate =  (config) ->
    throw new Error "HAProxy-storm.Validate - invalid input" unless config?
    if config? and not utils.isEmpty(config)
        chk = validate config, schema_HAProxy
        console.log 'HAProxy validate result ', chk
        unless chk.valid
            throw new Error "HAProxy schema check failed"+  chk.valid
            return  false
        else
            return true

module.exports.start = Start
module.exports.stop = Stop
module.exports.update = Update
#module.exports.validate = Validate