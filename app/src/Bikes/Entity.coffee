'use strict'

_ = require 'lodash'

class Entity

    constructor: (deps) ->
        @Adapter = deps?.adapters?.Adapter || require './Adapter'

    validateBikeUnlock: (inputMessage) ->
        adapter = new @Adapter

        @_unlockValidation inputMessage
            .then ->
                adapterMessage =
                    domain: 'S2Auth'
                    resource: 'auth'
                    data: inputMessage.data
                adapter.checkUserCredentials adapterMessage

    _unlockValidation: (inputMessage, interactorCallback) ->
        @_validate inputMessage, @_unlockRules(), (validationError) ->
            new Promise (resolve, reject) ->
                return reject status: 422, reason: validationError?.error?.fields if validationError?
                resolve()

    saveNewBikeStatus: (bikeStuff) ->
        new Promise (reject, resolve) ->
            resolve()

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
                        # fire request to S2Auth to check credentials
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