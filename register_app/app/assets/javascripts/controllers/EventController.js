"use strict";
var controllers = angular.module('controllers');
controllers.controller("EventController", [
  '$scope', '$routeParams', '$resource',
  function($scope, $routeParams, $resource) {
    var Event = $resource('http://api.lvh.me:3000/events/:eventId', { eventId: "@id" });

     Event.get({eventId: $routeParams.eventId},
      function(event){
          $scope.event = event
      },
      function(httpResponse) {
          $scope.event = null
      });
  }
]);
