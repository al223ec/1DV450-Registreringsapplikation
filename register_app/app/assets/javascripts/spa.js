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
    'ui.router',
    ]);

toerh.config(['$routeProvider', '$httpProvider', 'flashProvider','$locationProvider', 'jwtInterceptorProvider','$stateProvider','$urlRouterProvider',
    function($routeProvider, $httpProvider, flashProvider, $locationProvider, jwtInterceptorProvider, $stateProvider, $urlRouterProvider) {

        flashProvider.errorClassnames.push("flash-danger")
        flashProvider.warnClassnames.push("flash-warning")
        flashProvider.infoClassnames.push("flash-info")
        flashProvider.successClassnames.push("flash-success")

        $urlRouterProvider.otherwise("/events/list");
        $stateProvider
        .state('events', {
            url: '/events',
            abstract: true,
            templateUrl: 'app.html',
        })
        .state('events.list', {
            url: "/list",
            views: {
                'main': {
                    templateUrl: "events/index.html",
                    controller: 'EventsController'
                }
            }
        })
        .state('events.show', {
            url: '/{eventId:[0-9]{1,6}}',
            views: {
                'main': {
                    templateUrl: "events/show.html",
                    controller: 'EventController'
                }
            }
        })
        .state('events.new', {
            url: '/new',
            views: {
                'main': {
                    templateUrl: "events/create.html",
                    controller: 'EventController'
                }
            },
            data:{
                requiresLogin: true
            }
        })
        .state('events.edit',{
            url: '/edit',
            views: {
                'main': {
                    templateUrl: "events/create.html",
                    controller: 'EventController'
                }
            },
            data:{
                requiresLogin: true
            }
        })
        .state('users', {
            url: '/users',
            abstract: true,
            templateUrl: 'app.html',
        })
        .state('users.list', {
            url: "/all",
            views: {
                'main': {
                    templateUrl: "users/index.html",
                    controller: 'EndUsersController'
                }
            }
        })
        .state('users.show', {
            url: '/{endUserId:[0-9]{1,6}}',
            views: {
                'main': {
                    templateUrl: "users/show.html",
                    controller: 'EndUserController'
                }
            }
        })
        .state('login', {
            url: '/login',
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

toerh.run(['$state', 'store', '$rootScope', function($state, store, $rootScope ){
    $rootScope.$on('$stateChangeStart', function(e, to){
        if(to.data && to.data.requiresLogin){
            if(!store.get('jwt')){
                e.preventDefault();
                $state.go('login');
            }
        }
    })
}]);
var controllers = angular.module('controllers', []);
