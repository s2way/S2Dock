'use strict'

C = null

class Translator

    Interactor: require './Interactor'

    constructor: (deps) ->
        C = deps?.constants || require '../../Constants'

    take: (req, @_res, next) =>
        interactor = new @Interactor
        inputMessage =
            data: req.body

        respondOk = =>
            @_respond 200, 'ok'
        respondError = (errorMessage) =>
            @_respond errorMessage.status, errorMessage.reason or errorMessage

        # validate fields
        interactor.validate(inputMessage)
        .then respondOk
        .catch respondError

        next()

        # check credentials and stuff
        # save new bike status
        # save new station status@
        # respond ok





        # orderInteractor.create inputMessage, (outputMessage) =>
        #     if outputMessage?.error?
        #         errorMsg = @_handleError outputMessage.error
        #         @_respond res, errorMsg.status, errorMsg.message
        #     else
        #         id = {}
        #         if outputMessage?.success?.id?
        #             id =  outputMessage.success.id
        #         @_respond res, 201, id

        # @_respond res, 200, 'ok'

    _respond: (status, body) ->
        console.log 'chamou'
        @_res.json status, body

module.exports = Translator