(function() {
  "use strict";

  angular.module('gen.genericDirectives', [])
  .directive('genDynamicDirective', ['$compile',
    function($compile) {
      var makeInnerElement = function(scope, attrs, element) {
        var ngModelItem = scope.$eval(attrs.ngModel);                        
        scope.ngModelItem = ngModelItem;
        var getView = scope.$eval(attrs.genGetDynamicView);
        if (getView && typeof getView === 'function') {
          var templateUrl = getView(ngModelItem);
          if (templateUrl) {
            element.html('<div ng-include src="\'' + templateUrl + '\'"></div>');
          }
          $compile(element.contents())(scope);
        }
      };

      return {
        restrict: "E",
        require: '^ngModel',
        scope: true,
        link: function(scope, element, attrs, ngModel) {

          if (scope.$eval(attrs.ngModel)) {
            makeInnerElement(scope, attrs, element);
          } else {
            scope.$watch(attrs.ngModel, function(new_value, old_value) {
              if (old_value==null && new_value!=null) {
                makeInnerElement(scope, attrs, element);
              }
            });
          }
        }
      };
    }
    ]);
})();

