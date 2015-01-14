'use strict'

angular.module('app.form.validation', [])
# used for confirm password
# Note: if you modify the "confirm" input box, and then update the target input box to match it, it'll still show invalid style though the values are the same now
# Note2: also remember to use " ng-trim='false' " to disable the trim



# Comment out, use AngularJS built in directive instead.
# unique string, use on unique username, blacklist etc. 

# angularjs already support it, yet you get the picture
# validate number value, jquery free, only number >=x,  <= y are valid, e.g. 1~100, >= 0, <= -1...
# use with AngularJS built in type="number"
# .directive('minvalue', [ ->
#     return {
#         restrict: 'A'
#         require: 'ngModel'
#         link: (scope, ele, attrs, ngModelCtrl) ->
#             minVal = attrs.minvalue

#             validateVal = (value) ->
#                 valid = if value >= minVal then true else false
#                 ngModelCtrl.$setValidity('minVal', valid)

#             scope.$watch(attrs.ngModel, validateVal)

#     }
# ])
# .directive('maxvalue', [ ->
#     return {
#         restrict: 'A'
#         require: 'ngModel'
#         link: (scope, ele, attrs, ngModelCtrl) ->
#             maxVal = attrs.maxvalue

#             validateVal = (value) ->
#                 valid = if value <= maxVal then true else false
#                 ngModelCtrl.$setValidity('maxVal', valid)

#             scope.$watch(attrs.ngModel, validateVal)

#     }
# ])