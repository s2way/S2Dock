'use strict'
C = null
_ = require 'lodash'

class Entity

    constructor: (deps) ->
        C = require '../../Constants'
        @Adapter = deps?.adapters?.Adapter or require './Adapter'

    validateBikeUnlock: (inputMessage, translatorCallback) ->
        adapter = new @Adapter

        @_unlockValidation inputMessage, (validationError) ->
            return translatorCallback validationError if validationError?
            adapterMessage =
                domain: 'S2Auth'
                resource: 'auth'
                data: inputMessage.data
            adapter.checkUserCredentials adapterMessage, (checkError, credentials) ->
                return translatorCallback checkError if checkError?
                adapter.checkPermissions credentials, (permissionsError, granted) ->
                    return translatorCallback permissionsError if permissionsError?
                    # check if the user is allowed to take the bike (has money, is enabled and so on)
                    translatorCallback null, credentials

    _unlockValidation: (inputMessage, callback) ->
        @_validate inputMessage, @_unlockRules(), (validationError) ->
            return callback error: C.ERROR.VALIDATION_ERROR, reason: validationError?.error?.fields if validationError?
            callback()

    saveNewBikeStatus: (bikeStuff, interactorCallback) ->
        interactorCallback()

    _unlockRules: ->
        wpRules = require('waferpie-utils').Rules
        rules =
            validate:
                user: (value, data, callback) ->
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

    _validate: (inputMessage, rules, callback) ->
        validator = new (require('waferpie-utils').Validator)(rules)
        validator.validate inputMessage.data, (validationErrors) ->
            return callback error : validationErrors if validationErrors?
            callback()

module.exports = Entity