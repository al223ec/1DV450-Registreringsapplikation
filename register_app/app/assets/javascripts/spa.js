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
    'angularUtils.directives.dirPagination'
    ]);

toerh.config(['$routeProvider', '$httpProvider', 'flashProvider','$locationProvider', 'jwtInterceptorProvider','$stateProvider','$urlRouterProvider', 'paginationTemplateProvider',
    function($routeProvider, $httpProvider, flashProvider, $locationProvider, jwtInterceptorProvider, $stateProvider, $urlRouterProvider, paginationTemplateProvider) {

        flashProvider.errorClassnames.push("flash-danger")
        flashProvider.warnClassnames.push("flash-warning")
        flashProvider.infoClassnames.push("flash-info")
        flashProvider.successClassnames.push("flash-success")

        $stateProvider
        .state('profile', {
            url: '/profile',
            abstract: true,
            templateUrl: 'app.html',
            controller: 'AppController'
        })
        .state('profile.showProfile',{
            url: '/show',
            views: {
                'main': {
                    templateUrl: "profile/show.html",
                    controller: 'EndUserController'
                }
            },
            data:{
                requiresLogin: true
            }
        })
        .state('events', {
            url: '/events',
            abstract: true,
            templateUrl: 'app.html',
            controller: 'AppController'
        })
        .state('events.listEvents', {
            url: "/list",
            views: {
                'main': {
                    templateUrl: "events/index.html",
                }
            }
        })
        .state('events.showEvent', {
            url: '/{eventId:[0-9]{1,6}}',
            views: {
                'main': {
                    templateUrl: "events/show.html",
                    controller: 'EventController'
                }
            }
        })
        .state('events.listEvents.newEvent', {
            url: '/new',
            views: {
                'createevent': {
                    templateUrl: "events/create.html",
                    controller: 'EventController',
                }
            },
            data:{
                requiresLogin: true
            }
        })
        .state('events.listEvents.editEvent',{
            url: '/edit/{eventId:[0-9]{1,6}}',
            views: {
                'createevent': {
                    templateUrl: "events/create.html",
                    controller: 'EventController',
                }
            },
            data:{
                requiresLogin: true
            },
        })
        .state('users', {
            url: '/users',
            abstract: true,
            templateUrl: 'app.html',
            controller: 'AppController'
        })
        .state('users.listUsers', {
            url: "/list",
            views: {
                'main': {
                    templateUrl: "users/index.html",
                }
            }
        })
        .state('users.showUser', {
            url: '/{endUserId:[0-9]{1,6}}',
            views: {
                'main': {
                    templateUrl: "users/show.html",
                    controller: 'EndUserController'
                }
            }
        });
//      url: "*path",

        $httpProvider.defaults.headers.common = {
            'Authorization': 'Token token=elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t',
        };

        jwtInterceptorProvider.tokenGetter = function(store){
            return store.get('jwt');
        }

        jwtInterceptorProvider.authHeader = 'JWT';
        jwtInterceptorProvider.authPrefix = '';
        $httpProvider.interceptors.push('jwtInterceptor');

        $urlRouterProvider.otherwise("/events/list");
        // $locationProvider.html5Mode(true);
        //public folder
        paginationTemplateProvider.setPath('directives/dirPagination.tpl.html');
    }
]);

toerh.run(['$state', 'store', '$rootScope', 'flash', function($state, store, $rootScope, flash ){
    $rootScope.$on('$stateChangeStart', function(e, to){
        if(to.data && to.data.requiresLogin){
            if(!store.get('jwt')){
                e.preventDefault();
                $state.go('events.listEvents');
                console.log("not authenticated");
                flash.error = "V.g logga in";
            }
        }
    })
}]);
var controllers = angular.module('controllers', []);
