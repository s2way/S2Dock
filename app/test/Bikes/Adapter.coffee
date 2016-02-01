'use strict'

Adapter = require '../../src/Bikes/Adapter'
expect = require 'expect.js'
C = require '../../Constants'

describe 'The Bikes Adapter,', ->

    describe 'in its unlockBike method,', ->

        it 'should return an error if the validation fails', (done) ->

            input =
                data:
                    user: 'user'
                    password: 'pass'
                domain: 'S2Auth'

            expectedError = error: C.ERROR.UNAUTHORIZED, reason: 'because no'

            deps =
                connector:
                    http: ->
                        post: (request, callback) ->
                            callback statusCode: 401, body: 'because no'
                hosts: ->
                    S2Auth:
                        host: 'somehost'
                        resource: 'someresource'

            instance = new Adapter deps

            instance.checkUserCredentials input, (error, success) ->
                expect(error).to.eql expectedError
                done()