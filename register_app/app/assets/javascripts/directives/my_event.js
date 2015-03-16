"use strict";
var toerh = angular.module('toerh');
toerh.directive('myEvent', function(flash, $rootScope, eventService) {

  function link(scope, element, attrs) {
    scope.removeEvent = function(event){
          eventService.getEvent(event.id, function(event){
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

toerh.directive('myEventLister', function($routeParams, eventService, userService, flash, $rootScope) {
  function link(scope, element, attrs) {
    scope.events = [];
    scope.totalEvents = 0;
    //OBS måste ändra detta antal i vyn också av någon anledning
    scope.eventsPerPage = 5;
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
    //Visa knappar när det är aktuellt
    scope.endUserId = $rootScope.endUserId;

    scope.removeEvent = function(event){
      console.log(event);
    }
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
