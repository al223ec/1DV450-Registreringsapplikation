"use strict";
var controllers = angular.module('controllers');

controllers.controller("EndUserController", [
    '$scope', '$stateParams', 'userService', 'flash', '$state',
    function($scope, $stateParams, userService, flash, $state) {

        if($stateParams.endUserId){
            userService.getUserWithEvents($stateParams.endUserId, function(user) {
                $scope.user = user;
            });
        }else if($scope.decodedJwt){
            $scope.user = {};
            $scope.user.name = $scope.decodedJwt["name"];
            $scope.user.email = $scope.decodedJwt["email"];
            $scope.user.created_at = $scope.decodedJwt["created_at"];
            $scope.user.id = $scope.decodedJwt["end_user_id"];
        }

    $scope.setShowEvents = function(user){
      user.showEvents = user.showEvents ? false : true;
    }
}]);
