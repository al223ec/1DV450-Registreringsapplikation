"use strict";
var controllers = angular.module('controllers');
controllers.controller("AppController", ['$scope', "store", "jwtHelper", '$stateParams', 'flash', '$state', '$http', '$rootScope',
    function($scope, store, jwtHelper, $stateParams, flash, $state, $http, $rootScope) {

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

      loadJwtFromStore();
      //Hämta användaren

      function loadJwtFromStore(){
        $scope.jwt = store.get('jwt');
        $scope.decodedJwt = $scope.jwt && jwtHelper.decodeToken($scope.jwt);

        $scope.endUserId = $scope.decodedJwt ? $scope.decodedJwt["end_user_id"] : false;

        //För att nå detta id i mina direktiv
        $rootScope.endUserId = $scope.endUserId;

        if($scope.endUserId){
          var seconds = new Date().getTime() / 1000;
          if(seconds > $scope.decodedJwt.expiered){
            flash.error = "JWT sesionen har gått ut, du måste logga in på nytt!"
            $scope.logout();
            return;
          }

          $scope.currentUser = {};
          $scope.currentUser.name = $scope.decodedJwt["name"];
        }
      }

}]);
