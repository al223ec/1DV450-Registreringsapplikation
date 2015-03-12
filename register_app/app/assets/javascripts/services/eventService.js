"use strict"
var toerh = angular.module('toerh');

toerh.factory("eventService",['$state', '$http', '$resource','flash',
  function($state, $http, $resource, flash){
    // Denna bör vara i userService
    var EventByUserId = $resource('http://api.lvh.me:3000/end_users/:endUserId/events', {
      endUserId: "@id"
    });

    var Event = $resource('http://api.lvh.me:3000/events/:eventId', {
        eventId: "@id"
    },{
        'save':   {method:'PUT'},
        'create': {method:'POST'}
    });


    var Events = $resource('http://api.lvh.me:3000/events/?page=:page&per_page=:perPage',{
      page: "@page",
      perPage: "@perPage"
    });

    function defaultError(httpResponse){
        console.log(httpResponse);
        flash.error = "Ett fel har inträffat ! ";
    }

  return {
      getEvents: function(callback, error){
          Event.query({}, callback, error ? error : defaultError); // function(results) { $scope.events = results; });
      },
      getEvent: function(eventId, callback, error){

          Event.get({ eventId: eventId }, callback, error ? error : defaultError);
      },
      create: function(newEvent, callback, error){
          Event.create(newEvent, callback, error ? error : defaultError);
      }

  };
}]);
