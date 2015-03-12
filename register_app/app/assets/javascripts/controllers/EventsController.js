"use strict";
var controllers = angular.module('controllers');
controllers.controller("EventsController", ['$scope','$routeParams','eventService',
  function($scope, $routeParams, eventService) {

    eventService.getEvents(function(results) { $scope.events = results; }, function(httpResponse){});
    /*
    Kommer implementera denna senare
    $scope.search = function(keywords) {
      return $location.path("/").search('keywords', keywords);
    };
    if ($routeParams.keywords) {
      var queries = { queries: [$routeParams.keywords] };
      $http.post('http://api.lvh.me:3000/events/query', queries ).success(
        function (data){
          console.log(data);
          $scope.events = data;
      });
    } else {
        $scope.events = [];
    }
    */
  }
]);
