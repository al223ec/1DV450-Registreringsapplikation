"use strict";
var controllers = angular.module('controllers');
controllers.controller("EventController", ['$scope', '$routeParams', '$resource', 'flash', '$location',
    function($scope, $routeParams, $resource, flash, $location) {
        $scope.event = {};
        var Event = $resource('http://api.lvh.me:3000/events/:eventId',
        {
            eventId: "@id"
        },{
            'save':   {method:'PUT'},
            'create': {method:'POST'}
        });

        if($routeParams.eventId){
            Event.get({
                eventId: $routeParams.eventId
            }, function(event) {
                $scope.event = event
            }, function(httpResponse) {
                $scope.event = null
                flash.error = "There is no event with ID " + $routeParams.eventId;
            });
        }

        $scope.edit = function(){
            $location.path("/events/" + $scope.event.id + "/edit");
        }

        $scope.save = function(){
            if ($scope.event.id) {
                $scope.event.$save(
                    function(){ $location.path("/events/" + $scope.event.id)},
                    onError);
            } else {
                Event.create($scope.event,
                function(newEvent){ $location.path("/events/" + $scope.newEvent.id)},
                onError);
            }
        }

        function onError(httpResponse){
            console.log(httpResponse);
            flash.error = "något har gått fel";
        }
    }
]);
