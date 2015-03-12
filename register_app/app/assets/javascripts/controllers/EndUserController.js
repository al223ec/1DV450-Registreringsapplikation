"use strict";
var controllers = angular.module('controllers');
controllers.controller("EndUserController", ['$scope', '$stateParams', '$resource', 'flash', '$state',
    function($scope, $stateParams, $resource, flash, $state) {

        var Event = $resource('http://api.lvh.me:3000/end_users/:endUserId/events', {
            endUserId: "@id"
        });
        var User = $resource('http://api.lvh.me:3000/end_users/:endUserId', {
            endUserId: "@id"
        });

        User.get({
            endUserId: $stateParams.endUserId
        }, function(user) {
            $scope.user = user;
            Event.query({
                endUserId: $stateParams.endUserId
            }, function(events){
                $scope.user.events = events
            }, function(httpResponse) {
                $scope.user = null
                flash.error = "Kan inte hitta några events med userid " + $stateParams.endUserId;
            });
        }, function(httpResponse) {
            $scope.user = null
            flash.error = "There is no user with ID " + $stateParams.endUserId;
        });
    }
]);
