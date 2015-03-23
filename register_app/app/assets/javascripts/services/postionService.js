"use strict"
var toerh = angular.module('toerh');

toerh.factory("positionService",['$state', '$http', '$resource','flash', 'myConfig',
  function($state, $http, $resource, flash, myConfig){
    var Position = $resource(myConfig.baseUrl +'/positions/',{});

    function defaultError(httpResponse){
        console.log(httpResponse);
        flash.error = "Ett fel har inträffat ! ";
    }

  return {
      getPositions: function(callback, error){
          Position.query({}, callback, error ? error : defaultError);
      },
      create: function(position, callback, error){
          Position.create(position, callback, error ? error : defaultError);
      }
  };
}]);
