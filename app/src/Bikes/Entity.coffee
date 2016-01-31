'use strict'
C = null
_ = require 'lodash'

class Entity

    constructor: (deps) ->
        C = require '../../Constants'
        @Adapter = deps?.adapters?.Adapter or require './Adapter'

    validateBikeUnlock: (inputMessage) ->
        adapter = new @Adapter

        @_unlockValidation inputMessage
            .then ->
                adapterMessage =
                    domain: 'S2Auth'
                    resource: 'auth'
                    data: inputMessage.data
                adapter.checkUserCredentials adapterMessage
            .then (credentials) ->
                adapter.checkPermissions credentials
                # check if the user is allowed to take the bike (has money, is enabled and so on)

    _unlockValidation: (inputMessage) ->
        new Promise (resolve, reject) =>
            @_validate inputMessage, @_unlockRules(), (validationError) ->
                return reject error: C.ERROR.VALIDATION_ERROR, reason: validationError?.error?.fields if validationError?
                resolve()

    saveNewBikeStatus: (bikeStuff) ->
        new Promise (resolve, reject) ->
            resolve(bikeStuff)

    _unlockRules: ->
        wpRules = require('waferpie-utils').Rules
        rules =
            validate:
                user: (value, data, callback) =>
                    if _.isEmpty value
                        callback message: 'Field is invalid'
                    else
                        callback()
                password: (value, data, callback) ->
                    if _.isEmpty value
                        callback message: 'Field is invalid'
                    else
                        callback()
                station: (value, data, callback) ->
                    if _.isEmpty value
                        callback message: 'Field is invalid'
                    else
                        callback()
                dock: (value, data, callback) ->
                    if !wpRules.isUseful(value) or value is 0
                        callback message: 'Field is invalid'
                    else
                        callback()
                bike: (value, data, callback) ->
                    if _.isEmpty value
                        callback message: 'Field is invalid'
                    else
                        callback()


    _validate: (inputMessage, rules, interactorCallback) ->
        validator = new (require('waferpie-utils').Validator)(rules)
        validator.validate inputMessage.data, (validationErrors) ->
            return interactorCallback error : validationErrors if validationErrors?
            interactorCallback()

module.exports = Entity