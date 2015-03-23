"use strict"
var toerh = angular.module('toerh');

toerh.factory("tagService",['$http', '$resource','flash', 'myConfig',
  function($http, $resource, flash, myConfig){

    var TagEvents = $resource(myConfig.baseUrl +'/tags/:tagId/events/?page=:page&per_page=:perPage',{
        tagId: "@id",
        page: "@page",
        perPage: "@perPage"
    });

    function defaultError(httpResponse){
        console.log(httpResponse.data);
        var message = httpResponse.data && httpResponse.data.message ? httpResponse.data.message : ''
        flash.error = "Ett fel har inträffat ! " + message;
    }
    return {
      getEvents: function(tagId, pageNumber, eventsPerPage, callback, error){
          TagEvents.get({ tagId: tagId, page: pageNumber, perPage: eventsPerPage}, callback, error ? error : defaultError);
      },
    }
}]);
