var dragDrillApp = angular.module('dragDrillApp', []);

dragDrillApp.controller('DragDrillCtrl', function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL 
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2]

  $http.get('/drills/' + drill_id + '/read.json').success(function(data){
    $scope.drill = data
  });
});