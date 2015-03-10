"use strict";
var toerh = angular.module('toerh', ['templates', 'ngRoute', 'controllers', 'ngResource']);
toerh.config([
  '$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
    $routeProvider.when('/', {
      templateUrl: "index.html",
      controller: 'EventsController'
    });

    return $httpProvider.defaults.headers.common = {
      'Authorization': 'Token token=elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t'
    };
  }
]);

var controllers = angular.module('controllers', []);
