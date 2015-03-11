"use strict";
var controllers = angular.module('controllers');
controllers.controller("EventController", ['$scope', '$stateParams', '$resource', 'flash', '$state',
    function($scope, $stateParams, $resource, flash, $state) {
        $scope.event = {};
        var Position = $resource('http://api.lvh.me:3000/positions/',{});
        Position.query({}, function(positions) { $scope.positions = positions; });

        var Event = $resource('http://api.lvh.me:3000/events/:eventId',
        {
            eventId: "@id"
        },{
            'save':   {method:'PUT'},
            'create': {method:'POST'}
        });

        if($stateParams.eventId){
            Event.get({
                eventId: $stateParams.eventId
            }, function(event) {
                $scope.event = event
            }, function(httpResponse) {
                $scope.event = null
                flash.error = "There is no event with ID " + $stateParams.eventId;
            });
        }


        $scope.edit = function(){
        }

        $scope.save = function(){
            if ($scope.event.id) {
                $scope.event.$save(
                    function(){ $state.go('events.show', { eventId: $scope.event.id }); },
                    onError);
            } else {
                Event.create($scope.event,
                function(newEvent){ $state.go('events.show', { eventId: $scope.event.id }); },
                onError);
            }
        }

        function onError(httpResponse){
            console.log(httpResponse);
            flash.error = "något har gått fel";
        }
    }
]);
