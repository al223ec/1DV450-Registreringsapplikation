"use strict";

var controllers = angular.module('controllers');
controllers.controller("CreateEventController", ['$scope', '$stateParams', 'flash', '$state', 'eventService','positionService',
    function($scope, $stateParams, flash, $state, eventService, positionService) {
        $scope.event = {};
        $scope.event.tags = [];
        $scope.prompt = $stateParams.eventId ? "Skapa nytt event" : "Redigera event";
        positionService.getPositions(function(positions){$scope.positions = positions; });

        if($stateParams.eventId){
            eventService.getEvent($stateParams.eventId, function(event) {
                $scope.event = event;
                var stringTags = [];
                event.tags.forEach(function(tag) {
                    stringTags.push(tag.name);
                });
                $scope.stringTags = stringTags;
            }, function(httpResponse) {
                $scope.event = null
                flash.error = "Det finns inget event med ID " + $stateParams.eventId;
            });
        }

        $scope.save = function(){
            $scope.event.position_id = $scope.event.position.id;
            if ($scope.event.id) {
                $scope.event.$save(
                    function(){
                        flash.success = "Eventet updaterades!";
                        $state.go('events.showEvent', { eventId: $scope.event.id }); },
                    onError);
            } else {
                eventService.create($scope.event,
                    function(newEvent){
                        flash.success = "Eventet skapades!";
                        $state.go('events.showEvent', { eventId: newEvent.id }); },
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
            var message = httpResponse.data && httpResponse.data.message ? httpResponse.data.message : '';
            flash.error = "Ett fel har inträffat ! " + message;
        }
}]);


controllers.controller("ShowEventController", ['$scope', '$stateParams', 'flash', 'eventService',
    function($scope, $stateParams, flash, eventService) {
        //detta skulle kunna flyttas till event directivet
        if($stateParams.eventId){
            eventService.getEvent($stateParams.eventId, function(event) {
                $scope.event = event;
            },function(httpResponse) {
                $scope.event = null
                flash.error = "Det finns inget event med ID " + $stateParams.eventId;
            });
        }
}]);
