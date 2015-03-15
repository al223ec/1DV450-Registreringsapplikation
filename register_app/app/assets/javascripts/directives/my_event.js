"use strict";
var toerh = angular.module('toerh');
toerh.directive('myEvent', function() {
  return {
    templateUrl: '/templates/_event.html'
  };
});

toerh.directive('myEventLister', function($routeParams, eventService, userService, flash) {
  function link(scope, element, attrs) {
    scope.events = [];
    scope.totalEvents = 0;
    //OBS måste ändra detta antal i vyn också av någon anledning
    scope.eventsPerPage = 5; // this should match however many results your API puts on one page
    scope.pagination = {
        current: 1
    };

    scope.pageChanged = function(newPage) {
      if(scope.userId && scope.userId != 0){
        userService.getEventsPerPageFilteredByUser(scope.userId, newPage, scope.eventsPerPage,
          function(data) {
            scope.totalEvents = data.total_entries;
            scope.events = data.events;

            if(data.events.length == 0){
              flash.warn = "Användaren har inga events!";
            }
          });

      }else{
        eventService.getEventsPerPage(newPage, scope.eventsPerPage,
          function(data) {
            scope.totalEvents = data.total_entries;
            scope.events = data.events;
          });
      }
    };
    scope.pageChanged(1);//Hämta data on page load
    console.log("my-event directive builds");
  }
  return {
    scope: {
      userId: '=userid',
      itemType: '=itemtype'
    },
    link: link,
    templateUrl: '/templates/_events_list.html',
  };
});
