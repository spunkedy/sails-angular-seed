'use strict'

angular.module('app.tasks', [])

# cusor focus when dblclick to edit
.directive('taskFocus', [
    '$timeout'
    ($timeout) ->
        return {
            link: (scope, ele, attrs) ->
                scope.$watch(attrs.taskFocus, (newVal) ->
                    if newVal
                        $timeout( ->
                            ele[0].focus()
                        , 0, false)
                )
        }
])
.controller('headerTaskCtrl', [ 
    '$scope'
    ($scope) ->
])
.controller('pageTaskCtrl', [ 
    '$scope','$rootScope', 'logger'
    ($scope,$rootScope,logger) ->

        $scope.editedTask = null
        $scope.edit = (task)->
            $scope.editedTask = task

        $scope.doneEditing = (task) ->
            if($scope.editedTask)
                $scope.editedTask = null
                task.main = task.main.trim()

                if !task.main
                    $scope.remove(task)
                else
                    logger.log('Task updated')

        $scope.add = ->
            newTask = $scope.newTask.trim()

            if newTask.length is 0
                return

            $rootScope.tasks.push(
                main: newTask
                alt: $scope.currentUser.username
            )
            logger.logSuccess('New task: "' + newTask + '" added')

            $scope.newTask = ''

        $scope.remove = (task) ->
            index = $rootScope.tasks.indexOf(task)
            $scope.tasks.splice(index, 1)
            logger.logError('Task removed')
])
