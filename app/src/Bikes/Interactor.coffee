'use strict'

_ = require 'lodash'

class Interactor

    constructor: (deps) ->
        C = deps?.constants or require '../../Constants'
        @Entity = deps?.interactor?.Entity or require './Entity'

    unlockBike: (inputMessage) ->

        entity = new @Entity

        entity.validateBikeUnlock(inputMessage)
            .then (bikeStuff) ->
                entity.saveNewBikeStatus(bikeStuff)

module.exports = Interactor