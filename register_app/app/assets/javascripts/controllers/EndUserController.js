"use strict";
var controllers = angular.module('controllers');
controllers.controller("EndUserController", ['$scope', '$routeParams', '$resource', 'flash', '$location',
    function($scope, $routeParams, $resource, flash, $location) {

        var Event = $resource('http://api.lvh.me:3000/end_users/:endUserId/events', {
            endUserId: "@id"
        });
        var User = $resource('http://api.lvh.me:3000/end_users/:endUserId', {
            endUserId: "@id"
        });

        User.get({
            endUserId: $routeParams.endUserId
        }, function(user) {
            $scope.user = user

            Event.query({
                endUserId: $routeParams.endUserId
            }, function(events){
                $scope.user.events = events
            }, function(httpResponse) {
                $scope.user = null
                flash.error = "Kan inte hitta några events med userid " + $routeParams.endUserId;
            })
        }, function(httpResponse) {
            $scope.user = null
            flash.error = "There is no user with ID " + $routeParams.endUserId;
        });

        $scope.back = function() {
            $location.path("/")
        }
    }
]);
