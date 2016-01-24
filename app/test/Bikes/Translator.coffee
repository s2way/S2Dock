'use strict'

Translator = require '../../src/Bikes/Translator'
expect = require 'expect.js'

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

            req = {}

            expectedOutput =
                status: 500
                reason: 'theres a ghost in the closet'

            deps =
                interactor:
                    Interactor: ->
                        unlockBike: (stuff) ->
                            new Promise (resolve, reject) ->
                                throw expectedOutput

            instance = new Translator deps

            instance._respond = (status, body) ->
                expect(status).to.be expectedOutput.status
                expect(body).to.be expectedOutput.reason
                done()

            instance.take req, emptyRes, ->

        it 'should respond ok if the bike could be released', (done) ->

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
                done()

            instance.take req, emptyRes, ->