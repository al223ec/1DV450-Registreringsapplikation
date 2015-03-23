"use strict"
var toerh = angular.module('toerh');

toerh.factory("userService",['$state', '$http', '$resource','flash', 'myConfig',
  function($state, $http, $resource, flash, myConfig){
    var Events = $resource(myConfig.baseUrl +'/end_users/:endUserId/events',{
      page: "@page"
    });

    var EventsPagination = $resource(myConfig.baseUrl +'/end_users/:endUserId/events?page=:page&per_page=:perPage',{
      page: "@page",
      perPage: "@perPage",
      endUserId: "@id"
    });

    var User = $resource(myConfig.baseUrl +'/end_users/:endUserId', {
        endUserId: "@id"
    },{
        'save':   {method:'PUT'},
        'create': {method:'POST'}
    });

    var UserPagination = $resource(myConfig.baseUrl +'/end_users/?page=:page&per_page=:perPage',{
      page: "@page",
      perPage: "@perPage"
    });

    function defaultError(httpResponse){
        console.log(httpResponse);
        flash.error = "Ett fel har inträffat ! ";
    }

  return {
      getEvents: function(id, callback, error){
          Events.get({endUserId: id }, callback, error ? error : defaultError);
      },
      getUser: function(endUserId, callback, error){
          User.get({ endUserId: endUserId }, callback, error ? error : defaultError);
      },
      getUsers: function(callback, error){
          User.query({}, callback, error ? error : defaultError);
      },
      getUsersPerPage: function(pageNumber, eventsPerPage, callback, error){
          UserPagination.get({page: pageNumber, perPage: eventsPerPage}, callback, error ? error : defaultError);
      },
      getUserWithEvents: function(endUserId, callback, error){
          User.get({ endUserId: endUserId }, function(user){
            Events.get({ endUserId: endUserId }, function(results){
              user.events = results.events;
              callback(user);
            }, error ? error : defaultError);
          }, error ? error : defaultError);
      },
      getEventsPerPageFilteredByUser: function(endUserId, pageNumber, eventsPerPage, callback, error){
          EventsPagination.get({
            endUserId: endUserId,
            page: pageNumber,
            perPage: eventsPerPage},
            callback, error ? error : defaultError);
      }
  };
}]);
