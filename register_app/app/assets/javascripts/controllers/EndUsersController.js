"use strict";
var controllers = angular.module('controllers');
controllers.controller("EndUsersController", ['$scope', '$routeParams', '$resource', 'flash', '$location',
    function($scope, $routeParams, $resource, flash, $location) {
    var User;

    User = $resource('http://api.lvh.me:3000/end_users/:endUserId', {
      endUserId: "@id",
      format: 'json'
    });

    User.query({}, function(results) { $scope.users = results; });
    }
]);
