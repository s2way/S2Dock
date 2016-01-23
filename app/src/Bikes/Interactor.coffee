_ = require 'lodash'

class Translator

    validate: (inputMessage) ->
        new Promise (resolve, reject) ->
            reject status: 422, reason: validationError: 'no validation for you' unless inputMessage.data?
            resolve()

module.exports = Translator