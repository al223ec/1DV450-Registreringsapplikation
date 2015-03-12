"use strict";
var controllers = angular.module('controllers');
controllers.controller("EndUsersController", ['$scope', 'userService', 'flash',
    function($scope, userService, flash) {

    userService.getUsers(function(results) { $scope.users = results; });

    $scope.getEvents = function(user){
      if(user.events){
        user.showEvents = user.showEvents ? false : true;
        return;
      }
      userService.getEvents(user.id, function(events){
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
