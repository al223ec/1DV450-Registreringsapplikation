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
    $scope.search = (queries)->
      queries = queries.replace('/ /g','').split(",");
      $location.path("/").search('queries', queries)

    Event = $resource('http://api.lvh.me:3000/events/:eventId', { eventId: "@id", format: 'json' }, )

    if $routeParams.queries
      Event.query(queries: $routeParams.queries, (results)-> $scope.events = results)
    else
      $scope.events = []
])
