'use strict'

class Adapter

    constructor: (deps) ->
        @PersistentConnector = deps?.connector?.mysql or require('waferpie-utils').Connectors.Couchbase
        @ApiConnector = deps?.connector?.http or require('waferpie-utils').Connectors.Http
        @hosts = deps?.hosts || require '../configs/hosts'

    checkUserCredentials: (adapterMessage) ->
        b64Credentials = new Buffer("#{adapterMessage.data.user}:#{adapterMessage.data.password}").toString 'base64'
        request =
            url: @hosts["#{adapterMessage.domain}"].host
            path: @hosts["#{adapterMessage.domain}"].resource
            type: 'json' # extrair
            headers:
                Authorization: "Basic #{b64Credentials}"
            data:
                grant_type: 'client_credentials'

        connector = new @ApiConnector
        return new Promise (resolve, reject) ->
            connector.post request, (error, success)->
                return reject error if error?
                resolve JSON.parse success

module.exports = Adapter
