jQuery( document ).ready(function( $ ) {

  prepare_for_ajax = function(drill){
 
    drill.drill.exercises.forEach(function(exercise){
      exercise.exercise_items_attributes = exercise.exercise_items;
      delete exercise.exercise_items;
    });

    drill.drill.exercises_attributes = drill.drill.exercises;
    delete drill.drill.exercises;
    delete drill.drill.id;
    return drill;
  };


  $('.form-actions .submit-drill').click(function(){
    var the_drill = window.ocill_drill_variable;
    var the_drill_id = the_drill.drill.id;
    console.log("CHANGE THIS ONE:")
    console.log(the_drill);

    the_drill = prepare_for_ajax(the_drill);
    console.log("IS THIS BETTER:")
    console.log(the_drill);
    $.ajax({
      type: "PUT",
      dataType: "json",
      data: the_drill,
      url: '/drills/' + the_drill_id 
    }).done(function(got_sum) {
      toastr.success("That DID go as planned!");
      console.log("THE ONE THAT CAME BACK:")
      console.log(got_sum);
      // if ( angular.equals( got_sum, the_drill ) ) {
      //   console.log("SAME:  Angular thinks the object sent to the server and the one retrieved from it are the same");
      // } else {
      //   console.log("DIFFERENT:  Angular thinks the object sent to the server and the one retrieved from it are the same")
      // }
    }).fail(function(jqXHR, textStatus, errorThrown){
      console.log("THE AJAX ERROR");
      console.log(jqXHR);
      toastr.error("That didn't go as planned!");
    });

    event.preventDefault();
  });
});


var dragDrillApp = angular.module('dragDrillApp', ['gen.genericDirectives', 'ui.sortable']);

dragDrillApp.controller('DragDrillCtrl', [ "$scope", "$location", "$http", function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL 
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2]

  if (drill_id){
    $http.get('/drills/' + drill_id + '/read.json?type=simple').success(function(data){
      // delete data.action;
      // delete data.controller;
      $scope.drill = {};
      $scope.drill.drill = data;
      console.log("Here's the DRILL!!!!");
      console.log($scope.drill);
    }).error(function(data, status, headers, config) {
      $scope.drill = {};
    });
  } else {
    $scope.drill = {};    
  }

  $scope.$watch('drill', function(drill){
    if (!drill) return;
    if (!drill.drill) return;
    if (!drill.drill.exercises) return;
    drill.drill.exercises.forEach(function(exercise, index){
      if (!exercise) return;
      exercise.position = index;
      if (!exercise.exercise_items) return;
      exercise.exercise_items.forEach(function(exercise_item, index){
        exercise_item.position = index;
        exercise_item.acceptable_answers = [ index ];
      });
    });
   window.ocill_drill_variable = angular.copy(drill);
  }, true );

  $scope.drill_to_store = function(drill){};


  $scope.delete = function(index, parent_index){
    if (parent_index != -1) {
      // $scope.drill.exercises[parent_index].exercise_items.splice(index, 1);
      $scope.drill.drill.exercises[parent_index].exercise_items[index]._destroy=true;
    } else {
      // $scope.drill.exercises.splice(index, 1);
      $scope.drill.drill.exercises[index]._destroy=true;
    }
  }

  $scope.add_new_exercise_item = function(exercise){
    exercise.exercise_items.push({ id: "" });
  }

  $scope.add_new_exercise = function(drill){
    drill.exercises.push({exercise_items: [], id: ""});
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
}]);