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

        interactor.unlockBike inputMessage, (error, success) =>
            return @_respondFailure error if error?
            @_respondSuccess null, success

        next()

    return: (req, @_res, next) =>
        interactor = new @Interactor
        inputMessage =
            data: req.body

        interactor.returnBike inputMessage, (error, success) =>
            return @_respondFailure error if error?
            @_respondSuccess null, success

        next()

    _respondSuccess: (msg) =>
        @_respond 200, msg or 'ok'

    _respondFailure: (errorMessage) =>
        status = switch
            when (errorMessage?.error) is C.ERROR.VALIDATION_ERROR then 422
            when (errorMessage?.error) is C.ERROR.UNAUTHORIZED then 401
            when (errorMessage?.error) is C.ERROR.SERVER_ERROR then 500

        @_respond status, errorMessage?.reason or errorMessage

    _respond: (status, body, next) ->
        @_res.json status, body

module.exports = Translator