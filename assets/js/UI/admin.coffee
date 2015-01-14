'use strict'

angular.module('app.adminUsers', ['ngSailsBind'])

.controller('adminUsersCtrl', [
    '$scope', '$filter', '$sailsBind', '$log'
    ($scope, $filter ,$sailsBind, $log) ->
        # filter
        $scope.searchKeywords = ''
        $scope.filteredUsers = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageUsers = $scope.filteredUsers.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageUsers

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredUsers = $filter('filter')($scope.users, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredUsers = $filter('orderBy')($scope.users, rowName)

            # console.log $scope.filteredUsers
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageUsers = []

        $sailsBind.bind("user", $scope)
        $sailsBind.bind("task", $scope)
        # init
        #init = ->
            
        #    userWatch = $scope.$watch "users.length", (newValue, oldValue) ->
        #        $log.log "users loaded by length"
                #$scope.search()
                #$scope.select $scope.currentPage
            
                
        #        return

        #init()



])