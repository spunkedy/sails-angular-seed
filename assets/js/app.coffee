'use strict';


angular.module('app', [
    # Angular modules
    'ngRoute'
    'ngAnimate'
    'ngSailsBind'
    'angular.filter'

    # 3rd Party Modules
    'ui.bootstrap'
    'easypiechart'
    'mgo-angular-wizard'

    # Custom modules
    'app.ui.ctrls'
    'app.adminUsers'
    'app.tasks'
    'app.ui.services'
    'app.controllers'
    'app.directives'
    'app.ui.form.directives'
    'app.localization'
    
])
    
.constant('AUTH_EVENTS', {
  loginSuccess: 'auth-login-success',
  loginFailed: 'auth-login-failed',
  logoutSuccess: 'auth-logout-success',
  sessionTimeout: 'auth-session-timeout',
  notAuthenticated: 'auth-not-authenticated',
  notAuthorized: 'auth-not-authorized'
})
.config([
    '$routeProvider'
    ($routeProvider) ->
        $routeProvider
            .when(
                '/'                                         # dashboard
                redirectTo: '/dashboard'
            )
            .when(
                '/dashboard'
                templateUrl: 'views/dashboard.html'
            )

            #Tasks
            .when(
                '/tasks'
                templateUrl: 'views/tasks/view.html'
            )
            #Admin views
            .when(
                '/admin/users'
                templateUrl: 'views/admin/users.html'
            )

            # Forms
            .when(
                '/forms/elements'
                templateUrl: 'views/forms/elements.html'
            )
            .when(
                '/forms/layouts'
                templateUrl: 'views/forms/layouts.html'
            )
            .when(
                '/forms/validation'
                templateUrl: 'views/forms/validation.html'
            )
            .when(
                '/forms/wizard'
                templateUrl: 'views/forms/wizard.html'
            )

            # Tables
            .when(
                '/tables/static'
                templateUrl: 'views/tables/static.html'
            )
            .when(
                '/tables/responsive'
                templateUrl: 'views/tables/responsive.html'
            )
            .when(
                '/tables/dynamic'
                templateUrl: 'views/tables/dynamic.html'
            )

            # Charts
            .when(
                '/charts/others'
                templateUrl: 'views/charts/charts.html'
            )
            .when(
                '/charts/morris'
                templateUrl: 'views/charts/morris.html'
            )
            .when(
                '/charts/flot'
                templateUrl: 'views/charts/flot.html'
            )

            # Authorization pages
            .when(
                '/pages/signin'
                templateUrl: 'views/pages/signin.html'
            )
            .when(
                '/pages/signup'
                templateUrl: 'views/pages/signup.html'
            )
            
            #generic pages
            .when(
                '/404'
                templateUrl: 'views/pages/404.html'
            )
            .when(
                '/pages/500'
                templateUrl: 'views/pages/500.html'
            )
            .otherwise(
                redirectTo: '/404'
            )
])
.run ($rootScope, $location, AuthService,AUTH_EVENTS,$log,logger,Session,$route) ->

        

    # enumerate routes that don't need authentication
    routesThatDontRequireAuth = ["/pages/signin","/pages/signup"]

    # check if current location matches route  
    routeClean = (route) ->
        _.find routesThatDontRequireAuth, (noAuthRoute) ->
          s.startsWith route, noAuthRoute


    $rootScope.$on "$routeChangeStart", (event, next, current) ->
        # if route requires auth and user is not logged in    
        # redirect back to login
        #$log.log "checking route: " 
        #$log.log $location
        #$log.log "auth check: " + AuthService.isAuthenticated()
        $location.path "/" if routeClean($location.url()) and AuthService.isAuthenticated()
        $location.path "/pages/signin"  if not routeClean($location.url()) and not AuthService.isAuthenticated()
        return

    io.socket.on "message",(msg) ->
        $log.log msg
        if msg.message == 'onLogout'
            $rootScope.$broadcast AUTH_EVENTS.logoutSuccess  
        else if msg.message == 'onLogin'
            $rootScope.isLoggedIn()

    #Login handlers
    $rootScope.$on AUTH_EVENTS.loginSuccess, (event,next,current) ->
        $location.path "/"
        $log.log "Auth success in app.coffee"
        $route.reload()
        return
    $rootScope.$on AUTH_EVENTS.logoutSuccess, (event,next,current) ->        
        $rootScope.clearCurrentUser()                
        $location.path "/pages/signin"
        $route.reload()
        $log.log "logged out"
        return

    $rootScope.$on AUTH_EVENTS.notAuthorized, (event,next,current) ->
        $log.log "received not authorized message"
        $location.path "/pages/signin"
        $route.reload()
        
        return

        
    



