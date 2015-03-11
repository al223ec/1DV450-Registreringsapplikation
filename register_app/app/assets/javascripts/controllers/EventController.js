"use strict";
var controllers = angular.module('controllers');
controllers.controller("EventController", [
  '$scope', '$routeParams', '$resource', 'flash', '$location',
  function($scope, $routeParams, $resource, flash, $location) {
    var Event = $resource('http://api.lvh.me:3000/events/:eventId', { eventId: "@id" });

     Event.get({eventId: $routeParams.eventId},
      function(event){
          $scope.event = event
      },
      function(httpResponse) {
          $scope.event = null
           flash.error = "There is no event with ID " + $routeParams.eventId;
      });

     $scope.back = function(){
      $location.path("/")
    }
  }
]);
