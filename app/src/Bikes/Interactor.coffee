_ = require 'lodash'

class Interactor

    validateBikeUnlock: (inputMessage) ->
        new Promise (resolve, reject) ->
            return reject status: 422, reason: validationError: 'no validation for you' unless inputMessage.data?
            resolve()

module.exports = Interactor