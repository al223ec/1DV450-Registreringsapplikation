receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'controllers',
  'ngResource',
])

receta.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'EventsController'
      )
])

controllers = angular.module('controllers',[])
controllers.controller("EventsController", [ '$scope', '$routeParams', '$location', '$resource',

  ($scope,$routeParams,$location, $resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)

    Event = $resource('api.lvh.me:3000/events/:eventId', { recipeId: "@id", format: 'json' })

    if $routeParams.keywords
      Event.query(keywords: $routeParams.keywords, (results)-> $scope.events = results)
    else
      $scope.events = []
])
