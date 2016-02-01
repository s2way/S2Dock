'use strict'

Translator = require '../../src/Bikes/Translator'
expect = require 'expect.js'
C = require '../../Constants'

describe 'The Bikes translator,', ->

    describe 'in its take method,', ->

        instance = null
        emptyReq =
            query:
                options: {}
        emptyRes =
            json: ->
        defaultReq =
            body:
                user: '11144477735'
                password: 121212
                station: 777
                dock: 2
                bike: 'A123B456C789'
        resolvedPromise =
            new Promise (resolve, reject) ->
                resolve()

        it 'should respond an error if something supernatural happens when saving the new bike status', (done) ->

            respondCalled = false

            req = {}

            expectedOutput =
                error: C.ERROR.SERVER_ERROR
                reason: 'theres a ghost in the closet'

            deps =
                interactor:
                    Interactor: ->
                        unlockBike: (stuff) ->
                            new Promise (resolve, reject) ->
                                throw expectedOutput

            instance = new Translator deps

            instance._respond = (status, body, next) ->
                expect(status).to.be 500
                expect(body).to.be expectedOutput.reason
                respondCalled = true
                next()

            instance.take req, emptyRes, ->
                expect(respondCalled).to.be.ok()
                done()

        it 'should respond ok if the bike could be released', ->

            req = {}

            expectedOutput =
                status: 200

            deps =
                interactor:
                    Interactor: ->
                        unlockBike: (stuff) ->
                            resolvedPromise

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be expectedOutput.status

            instance.take req, emptyRes, ->