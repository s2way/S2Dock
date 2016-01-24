'use strict'

Interactor = require '../../src/Bikes/Interactor'
expect = require 'expect.js'

describe 'The interactor,', ->

    describe 'in its unlockBike method,', ->

        it 'should return a validation error if something in the post is missing'

            #     req = {}

            #     expectedOutput =
            #         status: 429
            #         reason: 'some validation error'

            #     deps =
            #         interactor:
            #             Interactor: ->
            #                 validateBikeUnlocking: ->
            #                     new Promise (resolve, reject) ->
            #                         reject(expectedOutput)

            #     instance = new Translator deps

            #     instance._respond = (status, body) ->
            #         expect(status).to.be expectedOutput.status
            #         expect(body).to.be expectedOutput.reason
            #         done()

            #     instance.take req, emptyRes, ->

        it 'should call saveNewBikeStatus if the validation passed'

            #     req = {}
            #     methodCalled = false

            #     expectedOutput =
            #         status: 200
            #         reason: 'ok'

            #     deps =
            #         interactor:
            #             Interactor: ->
            #                 validateBikeUnlocking: ->
            #                     resolvedPromise
            #                 newBikeStatus: (stuff) ->
            #                     methodCalled = true
            #                     resolvedPromise

            #     instance = new Translator deps

            #     instance._respond = (status, body) ->
            #         expect(methodCalled).to.be.ok()
            #         done()

            #     instance.take req, emptyRes, ->
