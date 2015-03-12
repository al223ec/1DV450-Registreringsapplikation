"use strict"
var toerh = angular.module('toerh');

toerh.factory("userService",['$state', '$http', '$resource','flash',
  function($state, $http, $resource, flash){
    var Events = $resource('http://api.lvh.me:3000/end_users/:endUserId/events', {
      endUserId: "@id"
    });
    var User = $resource('http://api.lvh.me:3000/end_users/:endUserId', {
        endUserId: "@id"
    },{
        'save':   {method:'PUT'},
        'create': {method:'POST'}
    });

    function defaultError(httpResponse){
        console.log(httpResponse);
        flash.error = "Ett fel har inträffat ! ";
    }

  return {
      getEvents: function(id, callback, error){
          Events.query({endUserId: id }, callback, error ? error : defaultError); // function(results) { $scope.events = results; });
      },
      getUser: function(endUserId, callback, error){
          User.get({ endUserId: endUserId }, callback, error ? error : defaultError);
      },
      getUsers: function(callback, error){
          User.query({}, callback, error ? error : defaultError);
      },
      getUserWithEvents: function(endUserId, callback, error){
          User.get({ endUserId: endUserId }, function(user){
            Events.query({ endUserId: endUserId }, function(events){
              user.events = events;
              callback(user);
            }, error ? error : defaultError);
          }, error ? error : defaultError);
      }
  };
}]);
