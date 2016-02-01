'use strict'

_ = require 'lodash'

class Interactor

    constructor: (deps) ->
        C = deps?.constants or require '../../Constants'
        @Entity = deps?.entity?.Entity or require './Entity'

    unlockBike: (inputMessage, translatorCallback) ->

        entity = new @Entity

        entity.validateBikeUnlock inputMessage, (error, success) ->
            return translatorCallback error if error?
            entity.saveNewBikeStatus success, (error, success) ->
                return translatorCallback error if error?
                translatorCallback()

    returnBike: (inputMessage, translatorCallback) ->
        entity = new @Entity

        entity.validateBikeReturn inputMessage, (error, success) ->
            return translatorCallback error if error?
            entity.saveRide success, (error, success) ->
                return translatorCallback error if error?
                translatorCallback()

module.exports = Interactor