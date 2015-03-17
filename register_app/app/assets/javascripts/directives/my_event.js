"use strict";
var toerh = angular.module('toerh');
toerh.directive('myEvent', function(flash, $rootScope, eventService) {

  function link(scope, element, attrs) {
    scope.removeEvent = function(){
          eventService.getEvent(scope.event.id,
            function(event){
              if(confirm("Bekräfta borttagning!")){
                event.$delete(
                function(){
                  element.remove()
                  flash.success = "Eventet togs bort!";
                },
                onError);
              }
          });
    }
    scope.endUserId = $rootScope.endUserId;
  }

  function onError(httpResponse){
    console.log(httpResponse);
    var message = httpResponse.data && httpResponse.data.message ? httpResponse.data.message : ''
    flash.error = "Ett fel har inträffat ! " + message;
  }

  return {
    templateUrl: '/templates/_event.html',
    scope: {
      event: '=event',
    },
    link: link,
  };
});

toerh.directive('myEventLister', function($routeParams, eventService, userService, tagService, flash, $rootScope) {
  function link(scope, element, attrs) {
    scope.events = [];
    scope.totalEvents = 0;
    //OBS måste ändra detta antal i vyn också av någon anledning
    scope.eventsPerPage = 5;
    scope.pagination = {
        current: 1
    };

    scope.pageChanged = function(newPage) {
      switch(scope.filter){
        case "user" :
          if(scope.value && scope.value != 0){
            userService.getEventsPerPageFilteredByUser(scope.value, newPage, scope.eventsPerPage,
              function(data) { scope.totalEvents = data.total_entries; scope.events = data.events;
                if(data.events.length == 0){
                  flash.warn = "Användaren har inga events!";
                }
              });
          } else {
            eventService.getEventsPerPage(newPage, scope.eventsPerPage,
            function(data) { scope.totalEvents = data.total_entries; scope.events = data.events; });
          }
          break;
        case "tag" :
          tagService.getEvents(scope.value, newPage, scope.eventsPerPage,
          function(data) { scope.totalEvents = data.total_entries; scope.events = data.events; });
          break;
        case "query" :
          eventService.filterEvents(scope.value, newPage, scope.eventsPerPage,  function(response) { console.log(response); scope.totalEvents = response.data.total_entries; scope.events = response.data.events; });
          break;
        default :
          console.log("Du har använt event lister directive felaktigt skanas värde för filter");
          break;
      }
    }

    scope.pageChanged(1);//Hämta data on page load
    console.log("my-event directive builds");
    //Visa knappar när det är aktuellt
    scope.endUserId = $rootScope.endUserId;
  }

  return {
    scope: {
      filter: '=filter',
      value: '=value',
    },
    link: link,
    templateUrl: '/templates/_events_list.html',
  };
});
