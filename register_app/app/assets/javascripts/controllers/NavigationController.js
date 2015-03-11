"use strict";
var controllers = angular.module('controllers');
controllers.controller("NavigationController", ['$scope', '$stateParams', 'flash', '$state',
    function($scope, $stateParams, flash, $state) {
        $scope.setShowLoginForm = function() {
          var re = new RegExp("\/login/");
          if(!re.test($state.current.url)){
              $scope.showLoginForm = $scope.showLoginForm ? false : true;
          }else{
              $scope.showLoginForm = false;
          }
        }
        $scope.login = function(end_user){
          $scope.showLoginForm = false;
          $scope.end_user = end_user == null? {} : end_user;
          $state.go('login');
        }

        $scope.$on('$locationChangeStart', routeChange);
        function routeChange (event, newUrl){
        }
    }
]);
