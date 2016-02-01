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

        it 'should respond an error if something supernatural happens when saving the new bike status', (done) ->

            respondCalled = false

            req = {}

            expectedOutput =
                error: C.ERROR.SERVER_ERROR
                reason: 'theres a ghost in the closet'

            deps =
                interactor:
                    Interactor: ->
                        unlockBike: (inputMessage, callback) ->
                            callback expectedOutput

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be 500
                expect(body).to.be expectedOutput.reason
                respondCalled = true

            instance.take req, emptyRes, ->
                expect(respondCalled).to.be.ok()
                done()

        it 'should respond ok if the bike could be released', (done) ->

            deps =
                interactor:
                    Interactor: ->
                        unlockBike: (inputMessage, callback) ->
                            callback()

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be 200
                expect(body).to.be 'ok'

            instance.take {}, emptyRes, ->
                done()

    describe 'in its return method,', ->

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

        it 'should respond an error if something supernatural happens when saving the new bike status', (done) ->

            respondCalled = false

            req = {}

            expectedOutput =
                error: C.ERROR.SERVER_ERROR
                reason: 'theres a ghost in the closet'

            deps =
                interactor:
                    Interactor: ->
                        returnBike: (inputMessage, callback) ->
                            callback expectedOutput

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be 500
                expect(body).to.be expectedOutput.reason
                respondCalled = true

            instance.return req, emptyRes, ->
                expect(respondCalled).to.be.ok()
                done()

        it 'should respond ok if the bike could be released', (done) ->

            deps =
                interactor:
                    Interactor: ->
                        returnBike: (inputMessage, callback) ->
                            callback()

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be 200
                expect(body).to.be 'ok'

            instance.return {}, emptyRes, ->
                done()