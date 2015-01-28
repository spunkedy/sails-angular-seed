'use strict';

angular.module('app.ui.services', [])

.factory "UserService", ($http, Session,$log) ->
  userService = {}
  userService.register = (user,errorCB,successCB) ->
    $log.log "trying to register user:"
    $log.log user
    io.socket.post "/user/register", user, (data, jwres) ->
      $log.log "returning from registration"
      if(data.err) 
        errorCB (data.err)
      else
        successCB (data)

    
  userService

.factory "AuthService", ($http, Session,$log) ->
  authService = {}
  authService.clearUser = ->
    Session.destroy()
    $log.log Session
  authService.processUser = (user,roles) ->
    $log.log user
    Session.create user.id, user.username, roles
    #$log.log "processed user"
    #$log.log user
    #$log.log Session
  authService.login = (credentials) ->
    $http.post("/auth/local", credentials).then (res) ->
      try
        if res.data.errors 
          throw("error logging in")
        else
          return res.data
      catch error
        throw res.data.errors

  
  authService.isAuthenticated = ->
    !!Session.userId

  authService.isAuthorized = (authorizedRoles) ->
    authorizedRoles = [authorizedRoles]  unless angular.isArray(authorizedRoles)
    authService.isAuthenticated() and authorizedRoles.indexOf(Session.userRole) isnt -1

  authService
  
.service "Session", ->
  sessionService = {}
  sessionService.id = null
  sessionService.userId = null
  sessionService.userRoles = []
  sessionService.create = (sessionId, userId, userRole) ->
    sessionService.id = sessionId
    sessionService.userId = userId
    sessionService.userRoles = userRole
    return

  sessionService.destroy = ->
    sessionService.id = null
    sessionService.userId = null
    sessionService.userRoles = []
    return

  sessionService



.factory('logger', [ ->

    # toastr setting.
    toastr.options =
        "closeButton": true
        "positionClass": "toast-bottom-right"
        "timeOut": "3000"

    logIt = (message, type) ->
        toastr[type](message)

    return {
        log: (message) ->
            logIt(message, 'info')
            # return is needed, otherwise AngularJS will error out 'Referencing a DOM node in Expression', thanks https://groups.google.com/forum/#!topic/angular/bsTbZ86WAY4
            return 

        logWarning: (message) ->
            logIt(message, 'warning')
            return

        logSuccess: (message) ->
            logIt(message, 'success')
            return

        logError: (message) ->
            logIt(message, 'error')
            return
    }
])









