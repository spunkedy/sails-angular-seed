'use strict';

angular.module('app.controllers', ['ngSailsBind'])

# overall control
.controller('AppCtrl', [
    '$rootScope','$scope', '$location','$log','$sailsBind','AUTH_EVENTS','Session', 'AuthService'
    ($rootScope,$scope, $location, $log,$sailsBind,AUTH_EVENTS,Session,AuthService) ->
        $scope.isSpecificPage = ->
            path = $location.path()
            return _.contains( ['/404', '/pages/500', '/pages/login', '/pages/signin', '/pages/signin1', '/pages/signin2', '/pages/signup', '/pages/signup1', '/pages/signup2'], path )


        $scope.currentUser = null
        $scope.main =
            brand: 'TaskMojo'
            name: '' # those which uses i18n can not be replaced for now.
            roles: []
        
        #user.sessionID

        #listen to auth notifications
        io.socket.get "/auth/listen"
        
        #check to see if we are already logged in
        
        $log.log "Checking Login"
        $rootScope.isLoggedIn = ->
            io.socket.get "/user/isLoggedIn", (data, jwres) ->
                $log.log "returning from isLoggedIn"
                $log.log data
                if !data   || (data.statusCode && data.statusCode = 401 )             
                    $log.log "Not authorized yet"
                else 
                    $log.log "Authorized from check"
                    if !$rootScope.tasks 
                        $sailsBind.bind("task", $rootScope)
                    $rootScope.setCurrentUser(data)
                    $rootScope.$broadcast AUTH_EVENTS.loginSuccess                
        $rootScope.isLoggedIn()


        $rootScope.setCurrentUser = (user) ->
            $log.log "Associating user"
            $log.log user
            roles = []
            angular.forEach user.roles, 
              (value) ->
                roles.push(value.groupName)

            AuthService.processUser user.user , roles
            $scope.currentUser = user.user
            $scope.main.name = user.user.username
            $scope.main.roles = roles
            $log.log "auth check: " + AuthService.isAuthenticated()

        $rootScope.clearCurrentUser = (user) ->
            $log.log "Deassociating user"
            AuthService.clearUser()
            $scope.currentUser = null
            $scope.main.name = null
            $scope.main.roles = []
        
        $rootScope.hasRole = (role) ->
            return _.contains($scope.main.roles, role)

        


])

.controller('NavCtrl', [
    '$rootScope','$scope', 'filterFilter','Session','AUTH_EVENTS'
    ($rootScope,$scope, filterFilter,Session,AUTH_EVENTS) ->
        # init
])

.controller('DashboardCtrl', [
    '$scope','$sailsBind'
    ($scope,$sailsBind) ->
        

])
