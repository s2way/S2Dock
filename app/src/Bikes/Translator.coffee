'use strict'

C = null

class Translator

    constructor: (deps) ->
        C = deps?.constants or require '../../Constants'
        @Interactor = deps?.interactor?.Interactor or require './Interactor'

    take: (req, @_res, next) =>
        interactor = new @Interactor
        inputMessage =
            data: req.body

        saveNewBikeStatus = (bikeAndStation) ->
            interactor.newBikeStatus bikeAndStation

        respondSuccess = =>
            @_respond 200, 'ok'

        respondFailure = (errorMessage) =>
            @_respond errorMessage.status, errorMessage.reason or errorMessage

        interactor.validateBikeUnlocking(inputMessage)
        .then saveNewBikeStatus
        .then respondSuccess
        .catch respondFailure

        next()

    _respond: (status, body) ->
        @_res.json status, body

module.exports = Translator