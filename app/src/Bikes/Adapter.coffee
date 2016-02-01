'use strict'
C = null

class Adapter

    constructor: (deps) ->
        C = require '../../Constants'
        @PersistentConnector = deps?.connector?.mysql or require('waferpie-utils').Connectors.Couchbase
        @ApiConnector = deps?.connector?.http or require('waferpie-utils').Connectors.Http
        @hosts = deps?.hosts || require '../configs/hosts'

    checkUserCredentials: (adapterMessage, entityCallback) ->
        b64Credentials = new Buffer("#{adapterMessage.data.user}:#{adapterMessage.data.password}").toString 'base64'
        request =
            url: @hosts["#{adapterMessage.domain}"]?.host
            path: @hosts["#{adapterMessage.domain}"]?.resource
            headers:
                Authorization: "Basic #{b64Credentials}"
            data:
                grant_type: 'client_credentials'

        connector = new @ApiConnector
        connector.post request, (error, success) ->
            if error?
                return entityCallback
                    error: switch
                        when error.statusCode is 401 then C.ERROR.UNAUTHORIZED
                        else C.ERROR.SERVER_ERROR
                    reason: error.body or error
            entityCallback JSON.parse success

    checkPermissions: (credentials, entityCallback) ->
        # request to the other API with the credentials
        entityCallback()


module.exports = Adapter
