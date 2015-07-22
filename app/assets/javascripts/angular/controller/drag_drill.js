jQuery( document ).ready(function( $ ) {
  prepare_for_ajax = function(drill){
    drill.drill.exercises.forEach(function(exercise){
       exercise.exercise_items.forEach(function(exercise_items){
         delete exercise_items.$$hashKey;
       });
       exercise.options = {}
       exercise.options.horizontal = exercise.horizontal;
       delete exercise.horizontal;
       exercise.exercise_items_attributes = exercise.exercise_items;
       delete exercise.exercise_items;
       delete exercise.$$hashKey;
     });
     drill.drill.exercises_attributes = drill.drill.exercises;
     delete drill.drill.exercises;
     delete drill.drill.id;
     return drill;
  };

  $('.drag-drill .submit-drill').click(function(event){
    var the_scope = angular.element($("#drag-drill-controller")[0]).scope();
    var the_drill = the_scope.drill;
    if ( the_drill ) {
      var the_drill_id = the_drill.drill.id;
      var final_drill = prepare_for_ajax(the_drill);
      console.log(final_drill);
      $.ajax({
        type: "PUT",
        dataType: "json",
        data: final_drill,
        url: '/drills/' + the_drill_id
      }).done(function(json) {
         window.location.href = '/drills/' + the_drill_id  + '/edit';
      }).fail(function(jqXHR, textStatus, errorThrown){
        toastr.error("Ocill did not successfully save your work.  Please take a screenshot and send it to Ocill support.");
      });
    } else {
      toastr.error("Ocill did not successfully save your work.  Please take a screenshot and send it to Ocill support.");
    }
    event.preventDefault();
  });
});


var dragDrillApp = angular.module('dragDrillApp', ['gen.genericDirectives', 'ui.sortable']);

dragDrillApp.controller('DragDrillCtrl', [ "$scope", "$location", "$http", function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL;
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2];

  if (drill_id){
    $http.get('/drills/' + drill_id + '/read.json?type=simple').success(function(data){
      $scope.drill = {};
      $scope.drill.drill = data;
    }).error(function(data, status, headers, config) {
      $scope.drill = {};
    });
  } else {
    $scope.drill = {};
  }

  // $scope.$watch('drill', function(drill){
  //   if (!drill) return;
  //   if (!drill.drill) return;
  //   if (!drill.drill.exercises) return;
  //   drill.drill.exercises.forEach(function(exercise, index){
  //     if (!exercise) return;
  //     exercise.position = index;
  //     if (!exercise.exercise_items) return;
  //     exercise.exercise_items.forEach(function(exercise_item, index){
  //       exercise_item.position = index;
  //       exercise_item.acceptable_answers = [ index ];
  //     });
  //   });
  //  window.ocill_drill_variable = angular.copy(drill);
  // }, true );

  $scope.drill_to_store = function(drill){};

  $scope.sortableOptionsOuter = {
      handle: '.handle'
    };

  $scope.sortableOptionsInner = {
      handle: '.handle'
    };

  $scope.delete = function(index, parent_index){
    if (parent_index != -1) {
      $scope.drill.drill.exercises[parent_index].exercise_items[index]._destroy=true;
    } else {
      $scope.drill.drill.exercises[index]._destroy=true;
    }
  }

  $scope.add_new_exercise_item = function(exercise){
    exercise.exercise_items.push({ id: "" });
  }

  $scope.add_new_exercise = function(drill){
    drill.exercises.push({exercise_items: [], id: "", drill_id: drill.id });
  }

   $scope.sortableOptions = {
    update: function(e, ui) {
     var output = ui.item;
    }
  };

  $scope.getView = function (item) {
     if (item && item.exercises) {
       return '/ng-templates/nested_exercises.html';
     } else if (item && item.exercise_items) {
      return '/ng-templates/nested_exercise_items.html';
    }
    return null;
  };
}]);
