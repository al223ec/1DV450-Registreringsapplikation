"use strict";
var toerh = angular.module('toerh');
toerh.directive('myUser', function() {
  return {
    templateUrl: '/templates/_user.html'
  };
});

toerh.directive('myUserLister', function($routeParams, eventService, userService) {
  function link(scope, element, attrs) {
    scope.users = [];
    scope.totalUsers = 0;

    scope.usersPerPage = 8;
    scope.pagination = {
        current: 1
    };

    scope.pageChanged = function(newPage) {

      userService.getUsersPerPage(newPage, scope.usersPerPage,
        function(data) {
          scope.totalUsers = data.total_entries;
          scope.users = data.users;
        });
    };
    scope.pageChanged(1);//Hämta data on page load

    scope.setShowEvents = function(user){
      user.showEvents = user.showEvents ? false : true;
    }
  }
  return {
    scope: {
    },
    link: link,
    templateUrl: '/templates/_users_list.html',
  };
});
