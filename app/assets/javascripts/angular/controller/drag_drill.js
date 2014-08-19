var dragDrillApp = angular.module('dragDrillApp', ['gen.genericDirectives', 'ui.sortable']);

dragDrillApp.controller('DragDrillCtrl', function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL 
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2]

  if (drill_id){
    $http.get('/drills/' + drill_id + '/read.json').success(function(data){
      $scope.drill = data;
    }).error(function(data, status, headers, config) {
      $scope.drill = {};
    });
  } else {
    $scope.drill = {};    
  }



  $scope.$watch('drill', function(drill){
    if (!drill) return;
    if (!drill.exercises) return;
    drill.exercises.forEach(function(exercise, index){
     if (!exercise) return;
     exercise.position = index;
     if (!exercise.exercise_items) return;
     exercise.exercise_items.forEach(function(exercise_item, index){
      exercise_item.position = index;
    });
   });
  }, true );

  $scope.drill_to_store = {};

  $scope.add_new_exercise_item = function(exercise){
    exercise.exercise_items.push({});
  }

  $scope.delete = function(index, parent_index){
    if (parent_index != -1) {
      $scope.drill.exercises[parent_index].exercise_items.splice(index, 1);
    } else {
      $scope.drill.exercises.splice(index, 1);
    }
  }

  $scope.add_new_exercise = function(drill){
    drill.exercises.push({exercise_items: []});
  }

	// Save the revised drill object

	$scope.submit = function() {
		//  change the placeholder element of each exercises
		//  and exercise_item so it holds the index value
		// It *might* be best to do this serverside.
		console.log("Oh Noes!  I don't do anything yet!!");
	}

   $scope.sortableOptions = {
    update: function(e, ui) {
     var output = ui.item;
     console.log(output);
			// console.log("****changes");
			// console.log(e);
			// console.log("****more changes");
			// console.log(ui);
    }
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