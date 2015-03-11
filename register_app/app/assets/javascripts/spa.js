"use strict";
var toerh = angular.module('toerh', [
    'templates',
    'ngRoute',
    'controllers',
    'ngResource',
    'ngAnimate',
    'angular-flash.service',
    'angular-flash.flash-alert-directive',
    'angular-storage',
    'angular-jwt',
    ]);

toerh.config(['$routeProvider', '$httpProvider', 'flashProvider','$locationProvider', 'jwtInterceptorProvider',
    function($routeProvider, $httpProvider, flashProvider, $locationProvider, jwtInterceptorProvider) {

        flashProvider.errorClassnames.push("flash-danger")
        flashProvider.warnClassnames.push("flash-warning")
        flashProvider.infoClassnames.push("flash-info")
        flashProvider.successClassnames.push("flash-success")

        $routeProvider
        .when('/', {
            templateUrl: "events/index.html",
            controller: 'EventsController'
        })
        .when('/events/new/', {
            templateUrl: "events/create.html",
            controller: 'EventController'
        })
        .when('/events/:eventId', {
            templateUrl: "events/show.html",
            controller: 'EventController'
        })
        .when('/users/', {
            templateUrl: "users/index.html",
            controller: 'EndUsersController'
        })
        .when('/users/:endUserId', {
            templateUrl: "users/show.html",
            controller: 'EndUserController'
        })
        .when('/login/', {
            templateUrl: "auth/index.html",
            controller: 'AuthController'
        });

        $httpProvider.defaults.headers.common = {
            'Authorization': 'Token token=elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t',
        };
        jwtInterceptorProvider.tokenGetter = function(store){
            return store.get('jwt');
        }

        jwtInterceptorProvider.authHeader = 'JWT';
        jwtInterceptorProvider.authPrefix = '';
        $httpProvider.interceptors.push('jwtInterceptor');
        // $locationProvider.html5Mode(true);
    }
]);

toerh.run(['store', '$rootScope', function(store, $rootScope ){
}]);
var controllers = angular.module('controllers', []);
