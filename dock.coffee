startServer = ->
    Server = require 'restwork'
    Routes = require './app/Routes'
    Handlers = require './app/Handlers'
    routes = new Routes()
    server = new Server routes.getRoutes(), Handlers
    port = process.env.APP_PORT or 1234

    server.start port, ->
        console.log "Started [ #{port} ] "

startServer()