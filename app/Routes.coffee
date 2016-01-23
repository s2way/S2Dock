class Routes

    getRoutes: () ->
        bike = new (require './src/Bikes/Translator')
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
            bikes: [
                {
                    httpMethod: 'post'
                    url: 'bikes/ride/'
                    method: bike.take
                }
            ]

module.exports = Routes
