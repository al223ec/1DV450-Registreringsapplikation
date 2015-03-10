receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
])

receta.config([ '$routeProvider', '$httpProvider',
  ($routeProvider, $httpProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'EventsController'
      )

    $httpProvider.defaults.headers.common = {'Authorization': 'Token token=elw6XrzgWYeTLduph8mcr9rxWsIAsigRCJLjQqpHzu8t'}
])

controllers = angular.module('controllers',[])
controllers.controller("EventsController", [ '$scope', '$routeParams', '$location', '$resource',

  ($scope,$routeParams,$location, $resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)

    Event = $resource('http://api.lvh.me:3000/events/:eventId', { eventId: "@id", format: 'json' }, )

    if $routeParams.keywords
      Event.query(keywords: $routeParams.keywords, (results)-> $scope.events = results)
    else
      $scope.events = []
])
