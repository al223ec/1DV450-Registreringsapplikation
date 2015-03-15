"use strict";

var controllers = angular.module('controllers');
controllers.controller("EventController", ['$scope', '$stateParams', 'flash', '$state', 'eventService','positionService',
    function($scope, $stateParams, flash, $state, eventService, positionService) {
        $scope.event = {};

        if($stateParams.eventId){
            eventService.getEvent($stateParams.eventId, function(event) {
                $scope.event = event
            }, function(httpResponse) {
                $scope.event = null
                flash.error = "There is no event with ID " + $stateParams.eventId;
            });
        }

        $scope.edit = function(){
        }

        $scope.save = function(){
            console.log($scope.event);

            if ($scope.event.id) {
                $scope.event.$save(
                    function(){ $state.go('events.show', { eventId: $scope.event.id }); },
                    onError);
            } else {
                eventService.create($scope.event,
                    function(newEvent){ $state.go('events.show', { eventId: $scope.event.id }); },
                    onError);
            }
        }

        function onError(httpResponse){
            console.log(httpResponse);
            flash.error = "något oväntat har gått fel";
        }
}]);

controllers.controller("CreateEventController", ['$scope', '$stateParams', 'flash', '$state', 'eventService','positionService',
    function($scope, $stateParams, flash, $state, eventService, positionService) {
        $scope.event = {};
        positionService.getPositions(function(positions){$scope.positions = positions; });
}]);
