"use strict";
var controllers = angular.module('controllers');
controllers.controller("EndUsersController", ['$scope', '$resource', 'flash',
    function($scope, $resource, flash) {
    var User;

    User = $resource('http://api.lvh.me:3000/end_users/:endUserId', {
      endUserId: "@id",
      format: 'json'
    });

    User.query({}, function(results) { $scope.users = results; });

    var Event = $resource('http://api.lvh.me:3000/end_users/:endUserId/events', {
        endUserId: "@id"
    });

    $scope.getEvents = function(user){
      if(user.events){
        user.showEvents = user.showEvents ? false : true;
        return;
      }
      Event.query({
        endUserId: user.id
      }, function(events){
        if(events.length == 0){
          flash.error = "Användaren har inte några events";
          return;
        }
        for (var i = 0; i < $scope.users.length; i++) {
          if(user.id == $scope.users[i].id){
            $scope.users[i].events = events;
          }
        }
        user.showEvents = true;
      }, function(httpResponse) {
          flash.error = "Kan inte hitta några events med userid " + user.id;
      });
      }
    }
]);
