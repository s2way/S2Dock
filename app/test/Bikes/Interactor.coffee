'use strict'

Interactor = require '../../src/Bikes/Interactor'
expect = require 'expect.js'
C = require '../../Constants'

describe 'The Bikes Interactor,', ->

    describe 'in its unlockBike method,', ->

        it 'should return an error if the validation fails', (done) ->

            expectedError = error: C.ERROR.VALIDATION_ERROR, reason: 'because yes'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage, callback) ->
                            callback expectedError

            instance = new Interactor deps

            instance.unlockBike {}, (error, success) ->
                expect(error).to.eql expectedError
                done()

        it 'should hand the bike data to save but return an error if it fails', ->

            expectedError = 'saving error'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage, callback) ->
                            callback()
                        saveNewBikeStatus: (bikeStuff, callback) ->
                            callback expectedError

            instance = new Interactor deps

            instance.unlockBike {}, (error, success) ->
                expect(error).to.eql expectedError

        it 'should go through the functions and return nothing if everything went as expected', ->

            bikeData = some: 'wheel'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage, callback) ->
                            callback null, bikeData
                        saveNewBikeStatus: (bikeStuff, callback) ->
                            expect(bikeStuff).to.eql bikeData
                            callback()

            instance = new Interactor deps

            instance.unlockBike {}, (error, success) ->
                expect(error).not.to.be.ok()
                expect(success).not.to.be.ok()

