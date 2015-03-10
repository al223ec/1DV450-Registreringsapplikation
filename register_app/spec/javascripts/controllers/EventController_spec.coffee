describe "EventController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  eventId     = 42

  fakeEvent   =
    id: eventId
    content: "Est asperiores exercitationem voluptate minima officia et et reiciendis.",
    created_at: "2015-03-01T17:17:02.396Z",
    url: "http://api.lvh.me:3000/events/119",
    end_user:
      id: 105,
      name: "Mitchell Gusikowski",
      email: "example-4@enduser.org",
      created_at: "2015-03-01T17:16:48.657Z",
      url: "http://api.lvh.me:3000/end_users/105"
    position:
      id: 3,
      address: "Kungsvägen 13, 856 40 Sundsvall, Sweden, Sundsvall, Västernorrlands län, Sweden",
      url: "http://api.lvh.me:3000/positions/3"
    tags: [
      tag:
        id: 1,
        name: "lol",
        url: "http://api.lvh.me:3000/tags/1"
      ]

  setupController =(eventExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.eventId = eventId

      request = new RegExp("\/events/#{eventId}")
      results = if eventExists
        [200, fakeEvent]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0],results[1])

      ctrl        = $controller('EventController',
                                $scope: scope)
    )

  beforeEach(module("toerh"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'event is found', ->
      beforeEach(setupController())
      it 'loads the given event', ->
        httpBackend.flush()
        expect(scope.event).toEqualData(fakeEvent)
    describe 'event is not found', ->
      beforeEach(setupController(false))
      it 'loads the given event', ->
        httpBackend.flush()
        expect(scope.event).toBe(null)
        # what else?!
