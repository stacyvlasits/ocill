var dragDrillApp = angular.module('dragDrillApp', ['gen.genericDirectives', 'ui.sortable']);

dragDrillApp.controller('DragDrillCtrl', function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL 
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2]

  $http.get('/drills/' + drill_id + '/read.json').success(function(data){
    $scope.drill = data;
  });

	$scope.sortableOptions = {
	  	update: function(e, exercise_items) {
	  		// console.log("update called in sortableOptions");
		   //  console.log(exercise_items);
		   //  console.log(e);
	  	},
			connectWith: ".apps-container",
	};

	$scope.getView = function (item) {
	  /*
	    you can return a different url
	    to load a different template dynamically
	    based on the provided item 
	    */

	  if (item && item.exercises) {
	    return '/ng-templates/nested_exercises.html';
	  } else if (item && item.exercise_items) {
	  	return '/ng-templates/nested_exercise_items.html';
	  }
	  return null;
	};	
});