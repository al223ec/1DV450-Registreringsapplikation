"use strict";
var toerh = angular.module('toerh', [
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
  ]);
toerh.config([
  '$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
    $routeProvider.when('/', {
      templateUrl: "index.html",
      controller: 'EventsController'
    }).when('/events/:eventId', {
      templateUrl: "show.html",
      controller: 'EventController'
    });

    return $httpProvider.defaults.headers.common = {
      // elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t
      'Authorization': 'Token token=elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t'
    };
  }
]);

var controllers = angular.module('controllers', []);
