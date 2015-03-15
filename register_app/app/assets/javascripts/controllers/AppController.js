"use strict";
var controllers = angular.module('controllers');
controllers.controller("AppController", ['$scope', "store", "jwtHelper", '$stateParams', 'flash', '$state', '$http',
    function($scope, store, jwtHelper, $stateParams, flash, $state, $http) {

      //Hämta användaren
      loadJwtFromStore();

      $scope.setShowLoginForm = function() {
          $scope.showLoginForm = $scope.showLoginForm ? false : true;
      }

      $scope.login = function(end_user){
        $scope.end_user = end_user == null? {} : end_user;
        postLogin()
      }
      //TODO::Flytta denna request
      function postLogin(){
        $http.post("http://api.lvh.me:3000/end_users/login", { end_user: $scope.end_user })
        .success(function(data){
          $scope.showLoginForm = false;
          store.set('jwt', data.jwt);
          flash.success = "Inloggningen lyckades";
          loadJwtFromStore();
        }).error(function(reason){
          flash.error = "Inloggningen misslyckades";
          console.log(reason);
          $scope.showLoginForm = true;
        })
      }

      $scope.logout = function(){
        store.set('jwt', null);
        $scope.endUserId = false;
        $scope.decodedJwt = null;
        $state.go('events.listEvents');
      }

      function loadJwtFromStore(){
        $scope.jwt = store.get('jwt');
        $scope.decodedJwt = $scope.jwt && jwtHelper.decodeToken($scope.jwt)
        $scope.endUserId = $scope.decodedJwt ? $scope.decodedJwt["end_user_id"] : false;
        if($scope.endUserId){
          $scope.currentUser = {};
          $scope.currentUser.name = $scope.decodedJwt["name"];
        }
       // $scope.currentUser.email = $scope.decodedJwt["email"];
       // $scope.currentUser.created_at = $scope.decodedJwt["created_at"];
       // $scope.currentUser.id = $scope.decodedJwt["end_user_id"];
      }

}]);
