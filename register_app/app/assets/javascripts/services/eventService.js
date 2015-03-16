"use strict"
var toerh = angular.module('toerh');

toerh.factory("eventService",['$http', '$resource','flash',
  function($http, $resource, flash){
    var Event = $resource('http://api.lvh.me:3000/events/:eventId', {
        eventId: "@id"
    },{
        'save':   {method:'PUT'},
        'create': {method:'POST'},
        'delete': {method: 'DELETE'}
    });

    var Events = $resource('http://api.lvh.me:3000/events/?page=:page&per_page=:perPage',{
      page: "@page",
      perPage: "@perPage"
    });

    function defaultError(httpResponse){
        console.log(httpResponse.data);
        var message = httpResponse.data && httpResponse.data.message ? httpResponse.data.message : ''
        flash.error = "Ett fel har inträffat ! " + message;
    }

  return {
      getEvents: function(callback, error){
          Event.get({}, callback, error ? error : defaultError);
      },
      queryEvents: function(callback, error){
          Event.query({}, callback, error ? error : defaultError);
      },
      getEvent: function(eventId, callback, error){
          Event.get({ eventId: eventId }, callback, error ? error : defaultError);
      },
      create: function(newEvent, callback, error){
          Event.create(newEvent, callback, error ? error : defaultError);
      },
      getEventsPerPage: function(pageNumber, eventsPerPage, callback, error){
          Events.get({page: pageNumber, perPage: eventsPerPage}, callback, error ? error : defaultError);
      },
 };
}]);
