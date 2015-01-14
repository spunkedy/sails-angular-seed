

angular.module('app.ui.form.directives', [])
.directive('validateEquals', [ () ->
    return {
        require: 'ngModel'
        link: (scope, ele, attrs, ngModelCtrl) ->
            validateEqual = (value) ->
                valid = ( value is scope.$eval(attrs.validateEquals) )
                ngModelCtrl.$setValidity('equal', valid)
                return valid? value : undefined

            ngModelCtrl.$parsers.push(validateEqual)
            ngModelCtrl.$formatters.push(validateEqual)

            scope.$watch(attrs.validateEquals, (newValue, oldValue) ->
                if newValue isnt oldValue # so that watch only fire after change, otherwise watch will fire on load and add invalid style to "confirm" input box
                    ngModelCtrl.$setViewValue(ngModelCtrl.$ViewValue)
            )
    }
])
# Dependency: http://www.eyecon.ro/bootstrap-slider/ OR https://github.com/seiyria/bootstrap-slider
.directive('uiRangeSlider', [ ->
    return {
        restrict: 'A'
        link: (scope, ele) ->
            ele.slider()
    }
])

# Dependency: https://github.com/grevory/bootstrap-file-input
.directive('uiFileUpload', [ ->
    return {
        restrict: 'A'
        link: (scope, ele) ->
            ele.bootstrapFileInput()
    }
])

# Dependency: https://github.com/xixilive/jquery-spinner
.directive('uiSpinner', [ ->
    return {
        restrict: 'A'
        compile: (ele, attrs) -> # link and compile do not work together
            ele.addClass('ui-spinner')

            return {
                post: ->
                    ele.spinner()
            }

        # link: (scope, ele) -> # link and compile do not work together
    }

])

# Dependency: https://github.com/rstaib/jquery-steps
.directive('uiWizardForm', [ ->
    return {
        link: (scope, ele) ->
            ele.steps()
    }
])


