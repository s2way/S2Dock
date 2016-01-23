'use strict'

Bike = require '../../src/Bikes/Translator'
expect = require 'expect.js'

describe 'The Bikes translator,', ->

    emptyCallback = ->

    describe 'in its take method,', ->

        instance = null
        emptyReq =
            query:
                options: {}
        emptyRes =
            json: ->

        it 'should return a validation error if something in the post is missing', (done) ->

            req = {}
                # body:
                #     user: '11144477735'
                #     password: 121212
                #     station: 777
                #     dock: 2
                #     bike: 'A123B456C789'

            expectedOutput =
                status: 429
                reason: 'some validation error'

            instance = new Bike
            instance.Interactor = ->
                validate: ->
                    new Promise (resolve, reject) ->
                        reject(expectedOutput)

            instance._respond = (status, body) ->
                expect(status).to.be expectedOutput.status
                expect(body).to.be expectedOutput.reason
                done()

            instance.take req, emptyRes, ->