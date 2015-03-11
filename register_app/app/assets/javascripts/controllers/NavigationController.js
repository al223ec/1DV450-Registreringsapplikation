"use strict";
var controllers = angular.module('controllers');
controllers.controller("NavigationController", ['$scope', '$routeParams', 'flash', '$location',
    function($scope, $routeParams, flash, $location) {
        $scope.setShowLoginForm = function() {
          var re = new RegExp("\/login/");
          if(!re.test($location.url())){
              $scope.showLoginForm = $scope.showLoginForm ? false : true;
          }else{
              $scope.showLoginForm = false;
          }
        }
        $scope.login = function(end_user){
          $scope.showLoginForm = false;
          $scope.end_user = end_user == null? {} : end_user;
          $location.path("/login/");
        }

        $scope.goToUsers = function(){
          $location.path("/users/");
        }
        $scope.goToHome = function(){
          $location.path("/");
        }

        $scope.viewUser = function(endUserId){
          $location.path("/users/" + endUserId);
        }
        $scope.viewEvent = function(eventId) {
          $location.path("/events/" + eventId);
        }
        $scope.newEvent = function(){
          $location.path("/events/new/");
        }

        $scope.$on('$locationChangeStart', routeChange);
        function routeChange (event, newUrl){
        }
    }
]);
