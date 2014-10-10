'use strict';

angular.module('app', [
    # Angular modules
    'ngRoute'
    'ngAnimate'
    'ngSailsBind'

    # 3rd Party Modules
    'ui.bootstrap'
    'easypiechart'
    'mgo-angular-wizard'

    # Custom modules
    'app.controllers'
])
    
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
            .otherwise(
                redirectTo: '/404'
            )
])


