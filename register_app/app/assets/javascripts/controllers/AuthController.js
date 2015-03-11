"use strict";
var controllers = angular.module('controllers');
controllers.controller("AuthController", [
  '$scope', '$location', '$http', 'flash', 'store',
  function($scope, $location, $http, flash, store) {
    //Om man loggar in från ett annat scope än denna kontroller
    if($scope.end_user){
      postLogin();
    }
    //Överlagras från authcontroller
    $scope.login = function(end_user){
      $scope.end_user = end_user;
      postLogin();
    }

    function postLogin(){

      $http.post("http://api.lvh.me:3000/end_users/login", { end_user: $scope.end_user })
      .success(function(data){

        store.set('jwt', data.jwt);
        console.log(store.get('jwt'));
        //TODO::Fixa meddelandet
        flash.success = "Inloggningen lyckades";
        $location.path("/");
      }).error(function(reason){
        flash.error = "Inloggningen misslyckades";
        console.log(reason);
      })
    }
  }
]);
