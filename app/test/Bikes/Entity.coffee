'use strict'

Entity = require '../../src/Bikes/Entity'
expect = require 'expect.js'
C = require '../../Constants'

describe 'The Bikes Entity,', ->

    describe 'in its validateBikeUnlock method,', ->

        it 'should return the validation error if any happens', (done) ->

            expectedError =
                field: 'invalid'

            instance = new Entity
            instance._validate = (inputMessage, rules, callback) ->
                callback error: fields: expectedError

            instance.validateBikeUnlock data: {}, (error, success) ->
                expect(error).to.eql error: C.ERROR.VALIDATION_ERROR, reason: expectedError
                done()

        it 'should return an error if the user credentials were rejected', (done) ->

            expectedAdapterMessage =
                domain: 'S2Auth'
                resource: 'auth'
                data:
                    some: 'data'

            expectedError =
                error: C.ERROR.UNAUTHORIZED

            deps =
                adapters:
                    Adapter: ->
                        checkUserCredentials: (adapterMessage, callback) ->
                            expect(adapterMessage).to.eql expectedAdapterMessage
                            callback expectedError


            instance = new Entity deps
            instance._validate = (inputMessage, rules, interactorCallback) ->
                interactorCallback()

            instance.validateBikeUnlock expectedAdapterMessage, (error, response) ->
                expect(error).to.eql expectedError
                done()

        it 'should return an error if the user credentials were rejected', (done) ->

            expectedAdapterMessage =
                data:
                    some: 'data'

            expectedError =
                error: C.ERROR.UNAUTHORIZED

            deps =
                adapters:
                    Adapter: ->
                        checkUserCredentials: (adapterMessage, callback) ->
                            callback()
                        checkPermissions: (credentials, callback) ->
                            callback expectedError


            instance = new Entity deps
            instance._validate = (inputMessage, rules, interactorCallback) ->
                interactorCallback()

            instance.validateBikeUnlock expectedAdapterMessage, (error, response) ->
                expect(error).to.eql expectedError
                done()

        it 'should return the credentials if everything is awesome', (done) ->

            input =
                data:
                    some: 'data'

            expectedResponse =
                'this is': 'your credentials'

            deps =
                adapters:
                    Adapter: ->
                        checkUserCredentials: (adapterMessage, callback) ->
                            callback null, expectedResponse
                        checkPermissions: (credentials, callback) ->
                            expect(credentials).to.eql expectedResponse
                            callback()

            instance = new Entity deps
            instance._validate = (inputMessage, rules, interactorCallback) ->
                interactorCallback()

            instance.validateBikeUnlock input, (error, response) ->
                expect(error).not.to.be.ok()
                expect(response).to.eql expectedResponse
                done()

