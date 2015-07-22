jQuery( document ).ready(function( $ ) {

  $('.drag-drill #submit-attempt').click(function(){
    var the_attempt = window.ocill_attempt_variable;
    if ( the_attempt ) {
      var attempt_json = { "attempt": the_attempt, "json": true };
      var the_drill_id = the_attempt.drill_id;
      $.ajax({
        type: "POST",
        dataType: "json",
        data: attempt_json,
        url: '/drills/' + the_drill_id + '/attempts.json',
      }).done(function(attempt) {
        window.location.href = '/drills/' + the_drill_id + '/attempts/' + attempt.id;
      }).fail(function(jqXHR, textStatus, errorThrown){
        toastr.error("Ocill did not successfully save your work.  Please contact the Ocill administrator.");
      });
    }
    event.preventDefault();
  });
});

var dragDrillAttemptApp = angular.module('dragDrillAttemptApp', ['gen.genericDirectives', 'ui.sortable']);

dragDrillAttemptApp.controller('DragDrillAttemptCtrl', [ "$scope", "$location", "$http", function ($scope, $location, $http) {
  var parser = document.createElement('a');
  parser.href = document.URL
  // e.g. /drills/457/edit
  drill_id = parser.pathname.split('/')[2]

  if (drill_id){
    $http.get('/drills/' + drill_id + '/read.json?type=shuffle').success(function(data){
      $scope.drill = {};
      $scope.drill.drill = data;
    }).error(function(data, status, headers, config) {
      $scope.drill = {};
    });
  } else {
    $scope.drill = {};
  }

  $scope.attempt = {
    drill_id: drill_id
   };

  $scope.$watch('drill', function(drill){
    if (!drill) return;
    if (!drill.drill) return;
    if (!drill.drill.exercises) return;
    var response_count = 0;
    $scope.attempt.responses = [];
    drill.drill.exercises.forEach(function(exercise, index){
      if (!exercise) return;

        if (!exercise.exercise_items) return;

        exercise.exercise_items.forEach(function(exercise_item, index){
          $scope.attempt.responses[response_count] = {};
          $scope.attempt.responses[response_count]["exercise_item_id"] = exercise_item.id;
          $scope.attempt.responses[response_count]["value"] = index;
          response_count++;
      });
    });
   window.ocill_drill_variable = angular.copy(drill);
   window.ocill_attempt_variable = angular.copy($scope.attempt);

  }, true );

  $scope.sortableOptionsOuter = {
      handle: '.handle'
    };

  $scope.sortableOptionsInner = {
      handle: '.handle'
    };

   $scope.sortableOptions = {
    update: function(e, ui) {
     var output = ui.item;
    }
  };

  $scope.getView = function (item) {

     if (item && item.exercises) {
       return '/ng-templates/nested_exercises_attempt.html';
     } else if (item && item.exercise_items) {
      return '/ng-templates/nested_exercise_items_attempt.html';
    }
    return null;
  };
}]);
