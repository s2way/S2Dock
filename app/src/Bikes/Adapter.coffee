'use strict'
C = null

class Adapter

    constructor: (deps) ->
        C = require '../../Constants'
        @PersistentConnector = deps?.connector?.mysql or require('waferpie-utils').Connectors.Couchbase
        @ApiConnector = deps?.connector?.http or require('waferpie-utils').Connectors.Http
        @hosts = deps?.hosts || require '../configs/hosts'

    checkUserCredentials: (adapterMessage) ->
        b64Credentials = new Buffer("#{adapterMessage.data.user}:#{adapterMessage.data.password}").toString 'base64'
        request =
            url: @hosts["#{adapterMessage.domain}"].host
            path: @hosts["#{adapterMessage.domain}"].resource
            headers:
                Authorization: "Basic #{b64Credentials}"
            data:
                grant_type: 'client_credentials'

        connector = new @ApiConnector
        return new Promise (resolve, reject) ->
            connector.post request, (error, success) ->
                if error?
                    return reject
                        error: switch
                            when error.statusCode is 401 then C.ERROR.UNAUTHORIZED
                            else C.ERROR.SERVER_ERROR
                        reason: error.body
                resolve JSON.parse success

    checkPermissions: (credentials) ->
        # request to the other API with the credentials
        new Promise (resolve, reject) ->
            resolve('yes, you can')


module.exports = Adapter
