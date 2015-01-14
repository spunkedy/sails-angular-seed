'use strict';

angular.module('app.ui.ctrls', [])
.controller "registerController", 
    ($scope,UserService,$log,logger,$location,$route) ->

        $scope.userErrors = 
            username: ''
            email: ''
            password: ''
            confirmation: ''

        $scope.user = 
            username: ''
            email: ''
            password: ''
            confirmation: ''

        $scope.register =  (user)->
            $log.log "submitting"
            UserService.register user,
                (error) ->
                    if(error.invalidAttributes)
                        if(error.invalidAttributes.username)                         
                            logger.logError error.invalidAttributes.username[0].message
                        if(error.invalidAttributes.email)                         
                            logger.logError error.invalidAttributes.email[0].message
                        if(error.invalidAttributes.password) 
                            logger.logError error.invalidAttributes.password[0].message
                    else if (error.message)
                        logger.logError error.message
                    $log.log "error submitting"
                    $log.log error
                (success) ->
                    $location.path "/pages/signin"
                    $route.reload()
                    logger.logSuccess "You have been registered"




.controller "LoginController", 
($scope, $rootScope, AUTH_EVENTS, AuthService,logger,$log) ->
  $scope.credentials =
    username: ""
    password: ""

  $scope.login = (credentials) ->
    AuthService.login(credentials).then ((user) ->
      $log.log("Trying to log in")
      $rootScope.isLoggedIn()
      #$rootScope.setCurrentUser(user)

      return
    ), (response)->
        $log.log "error"
        $log.log response
        logger.logError response
      return

    return

  return


.controller('NotifyCtrl', [
    '$scope', 'logger'
    ($scope, logger) ->
        $scope.notify = (type)->
            switch type
                when 'info' then logger.log("Heads up! This alert needs your attention, but it's not super important.") 
                when 'success' then logger.logSuccess("Well done! You successfully read this important alert message.")
                when 'warning' then logger.logWarning("Warning! Best check yo self, you're not looking too good.")
                when 'error' then logger.logError("Oh snap! Change a few things up and try submitting again.")
])








