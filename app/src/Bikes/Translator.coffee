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

        unlockBike = (bikeAndStation) ->
            interactor.unlockBike bikeAndStation

        respondSuccess = (msg) =>
            @_respond 200, msg or 'ok'

        respondFailure = (errorMessage) =>
            status = switch
                when (errorMessage?.error) is C.ERROR.VALIDATION_ERROR then 422
                when (errorMessage?.error) is C.ERROR.UNAUTHORIZED then 401
            @_respond status, errorMessage?.reason or errorMessage

        interactor.unlockBike(inputMessage)
            .then respondSuccess
            .catch respondFailure

        next()

    _respond: (status, body) ->
        @_res.json status, body

module.exports = Translator