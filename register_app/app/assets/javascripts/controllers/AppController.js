"use strict";
var controllers = angular.module('controllers');
controllers.controller("AppController", ['$scope', "store", "jwtHelper", '$stateParams', 'flash', '$state', '$http',
    function($scope, store, jwtHelper, $stateParams, flash, $state, $http) {
      $scope.jwt = store.get('jwt');
      $scope.decodedJwt = $scope.jwt && jwtHelper.decodeToken($scope.jwt)
      $scope.endUserId = $scope.decodedJwt ? $scope.decodedJwt["end_user_id"] : false;

      $scope.setShowLoginForm = function() {
          $scope.showLoginForm = $scope.showLoginForm ? false : true;
      }

      $scope.login = function(end_user){
        $scope.showLoginForm = false;
        $scope.end_user = end_user == null? {} : end_user;
        postLogin()
      }
      //TODO::Flytta denna request
      function postLogin(){
        $http.post("http://api.lvh.me:3000/end_users/login", { end_user: $scope.end_user })
        .success(function(data){
          store.set('jwt', data.jwt);
          flash.success = "Inloggningen lyckades";
        }).error(function(reason){
          flash.error = "Inloggningen misslyckades";
          console.log(reason);
          $scope.showLoginForm = true;
        })
      }

}]);
