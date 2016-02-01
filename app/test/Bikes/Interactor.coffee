'use strict'

Interactor = require '../../src/Bikes/Interactor'
expect = require 'expect.js'
C = require '../../Constants'

describe 'The Interactor,', ->

    describe 'in its unlockBike method,', ->

        it 'should return an error if the validation fails', ->

            expectedError = error: C.ERROR.VALIDATION_ERROR, reason: 'because yes'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage) ->
                            new Promise (resolve, reject) ->
                                reject expectedError

            instance = new Interactor deps

            instance.unlockBike().catch (error) ->
                expect(error).to.eql expectedError

        it 'should call hand the bike data to the next function and then return nothing if the saving went fine', ->

            expectedError = 'no you cant'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage) ->
                            new Promise (resolve, reject) ->
                                resolve some: 'stuff'
                        saveNewBikeStatus: (bikeStuff) ->
                            new Promise (resolve, reject) ->
                                reject expectedError

            instance = new Interactor deps

            instance.unlockBike().catch (error) ->
                expect(error).to.eql expectedError

        it 'should call hand the bike data to the next function and then return nothing if the saving went fine', ->

            bikeData = some: 'wheel'

            deps =
                entity:
                    Entity: ->
                        validateBikeUnlock: (inputMessage) ->
                            new Promise (resolve, reject) ->
                                resolve bikeData
                        saveNewBikeStatus: (bikeStuff) ->
                            expect(bikeStuff).to.eql bikeData
                            null

            instance = new Interactor deps

            instance.unlockBike().then (saveResponse) ->
                expect(saveResponse).not.to.be.ok()

