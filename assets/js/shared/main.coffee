'use strict';

angular.module('app.controllers', ['ngSailsBind'])

# overall control
.controller('AppCtrl', [
    '$scope', '$location'
    ($scope, $location) ->
        $scope.isSpecificPage = ->
            path = $location.path()
            return _.contains( ['/404', '/pages/500', '/pages/login', '/pages/signin', '/pages/signin1', '/pages/signin2', '/pages/signup', '/pages/signup1', '/pages/signup2'], path )

        $scope.main =
            brand: 'iFlat'
            name: 'Lisa Doe' # those which uses i18n can not be replaced for now.


])

.controller('DashboardCtrl', [
    '$scope','$sailsBind'
    ($scope,$sailsBind) ->
        $sailsBind.bind("task", $scope)
        $scope.name = "background binding"
])
