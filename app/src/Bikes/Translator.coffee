'use strict'

class Translator

    constructor: (deps) ->
        @Interactor = deps?.interactor?.Interactor or require './Interactor'

    take: (req, @_res, next) =>
        interactor = new @Interactor
        inputMessage =
            data: req.body

        unlockBike = (bikeAndStation) ->
            interactor.unlockBike bikeAndStation

        respondSuccess = =>
            @_respond 200, 'ok'

        respondFailure = (errorMessage) =>
            @_respond errorMessage.status, errorMessage.reason or errorMessage

        interactor.unlockBike(inputMessage)
            .then respondSuccess
            .catch respondFailure

        next()

    _respond: (status, body) ->
        @_res.json status, body

module.exports = Translator