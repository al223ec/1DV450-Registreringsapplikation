"use strict";

var controllers = angular.module('controllers');
controllers.controller("EventController", ['$scope', '$stateParams', 'flash', '$state', 'eventService','positionService',
    function($scope, $stateParams, flash, $state, eventService, positionService) {
        $scope.event = {};
        $scope.event.tags = [];

        if($stateParams.eventId){
            eventService.getEvent($stateParams.eventId, function(event) {
                $scope.event = event
                var stringTags = [];
                event.tags.forEach(function(tag) {
                    stringTags.push(tag.name);
                });
                $scope.stringTags = stringTags;
            }, function(httpResponse) {
                $scope.event = null
                flash.error = "There is no event with ID " + $stateParams.eventId;
            });
        }

        $scope.edit = function(){
        }

        $scope.save = function(){
            $scope.event.position_id = $scope.event.position.id;
            if ($scope.event.id) {
                $scope.event.$save(
                    function(){ $state.go('events.showEvent', { eventId: $scope.event.id }); },
                    onError);
            } else {
                eventService.create($scope.event,
                    function(newEvent){ $state.go('events.showEvent', { eventId: newEvent.id }); },
                    onError);
            }
        }
        $scope.selectTag = function(stringTags){
            stringTags.trim();
            var tagObjects = [];
            stringTags.split(',').filter(Boolean).forEach(function(tag){
                tagObjects.push({name: tag.trim()});
            })
            $scope.event.tags = tagObjects;
        }

        function onError(httpResponse){
            console.log(httpResponse);
            flash.error = "något oväntat har gått fel";
        }

        positionService.getPositions(function(positions){$scope.positions = positions; });

}]);

controllers.controller("CreateEventController", ['$scope', '$stateParams', 'flash', '$state', 'eventService','positionService',
    function($scope, $stateParams, flash, $state, eventService, positionService) {
        $scope.event = {};
        positionService.getPositions(function(positions){$scope.positions = positions; });
}]);
