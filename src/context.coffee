validate = require('json-schema').validate
assert = require 'assert'
Promise = require 'bluebird'
async = require 'async'
needle = Promise.promisifyAll(require('needle'))
utils = require('utils')._
schema_haproxy = require('./schema').schema_haproxy

getPromise = ->
    return new Promise (resolve, reject) ->
        resolve()

Validate =  (config, schema_configs) ->
    throw new Error "haproxy Validate - invalid input" unless config
    checkschema = validate config, schema_configs
    console.log 'haproxy schema validate result: ', checkschema
    unless checkschema.valid
        throw new Error "HAProxy schema check failed"+  checkschema.valid
        return  false
    else
        return true

PostHAProxy = (baseUrl,config)->
    needle.postAsync baseUrl + "/haproxy", config, json:true
    .then (resp) =>
        #console.log "statuscode: ", resp[0].statusCode
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 200
        console.log "response code from post on haproxy - #{resp[0].statusCode}"
        #console.log "response from post on haproxy - #{resp[1]}"
        return resp[1].id
    .catch (err) =>
        throw err

DeleteHAProxy = (baseUrl,instanceid)->
    needle.deleteAsync baseUrl + "/haproxy/#{instanceid}", json:true
    .then (resp) =>
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 204
        return true
    .catch (err) =>
        throw err

PutHAProxy = (baseUrl,instanceid,config)->
    needle.putAsync baseUrl + "/haproxy/#{instanceid}", config, json:true
    .then (resp) =>
        throw new Error 'invalidStatusCode' unless resp[0].statusCode is 200
        return true
    .catch (err) =>
        throw err

Start =  (context) ->
    throw new Error 'haproxy-storm.Start missingParams' unless context.bInstalledPackages and context.service.name and context.service.factoryConfig?

    if context.instance? and context.instance?.length > 0
        return context

    configObj = context.service.factoryConfig?.config
    config = configObj[context.service.name]
#    config = context.service.factoryConfig?.config

    throw new Error 'haproxy-storm.Start missingParams' unless config?

    context.instance ?= []

    getPromise()
    .then () =>
        return Validate(config,schema_haproxy)
    .then (resp) =>
        return PostHAProxy(context.baseUrl,config)
    .then (resp) =>
        context.instance.push resp
        console.log "Start haproxy for instance: ", context.instance
        context.bFactoryPush = true
        return context
    .catch (err) =>
        throw err


Stop =  (context) ->
    throw new Error 'haproxy-storm.Stop missingParams' unless context.bInstalledPackages and context.service.name
    throw new Error 'haproxy-strom.Stop Instance is empty' if utils.isEmpty(context.instance)
    instance = context.instance
    getPromise()
    .then (resp) =>
         #console.log "Stop for instance:  ",instance
         return  DeleteHAProxy(context.baseUrl,instance)
    .then (resp) =>
        console.log "Stop haproxy Instance: ",instance
        delete context.instance
        context.instance = null
        context.bFactoryPush = false
        return context
    .catch (err) =>
        throw err

Update =  (context) ->
    throw new Error 'haproxy-storm.Update missingParams' unless context.bInstalledPackages and context.service.name and context.policyConfig
    throw new Error 'haproxy-strom.Update Instance is empty' if utils.isEmpty(context.instance)
    instance = context.instance
    policyconfig = context.policyConfig[context.service.name]
#    policyconfig = context.service.policyConfig?.config
    #console.log "PUT Update haproxy for instance: ", context.instance
    getPromise()
    .then () =>
        return Validate(policyconfig,schema_haproxy)
    .then (resp) =>
        console.log "Update haproxy for instance : ", instance
        return PutHAProxy(context.baseUrl,instance,policyconfig)
    .then (resp) =>
        #console.log "Update for instance #{context.instance}: is ", resp
        return context
    .catch (err) =>
        throw err

module.exports.start = Start
module.exports.stop = Stop
module.exports.update = Update
module.exports.validate = Validate
