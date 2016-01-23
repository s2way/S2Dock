class Routes

    getRoutes: () ->
        routes =
            keepAlive: [
                {
                    httpMethod: 'get'
                    url: '/'
                    method: (req, res, next) ->
                        res.json 200, 'OK'
                        next()
                }
            ]

module.exports = Routes