describe "EventsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null

  # access injected service later
  httpBackend  = null

  setupController =(keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords
      # capture the injected service
      httpBackend = $httpBackend

      if results
        request = new RegExp("\/query")
        httpBackend.expectPOST(request).respond(results)

      ctrl        = $controller('EventsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("toerh"))
  beforeEach(setupController())

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
  describe 'when no keywords present', ->
    beforeEach(setupController())

    it 'defaults to no events', ->
      expect(scope.events).toEqualData([])


  describe 'with keywords', ->
    keywords = 'foo'
    events = [
      {
        id: 2
        content: 'Baked Potatoes'
      },
      {
        id: 4
        content: 'Potatoes Au Gratin'
      }
    ]
    beforeEach ->
      setupController(keywords, events)
      httpBackend.flush()

    it 'calls the back-end', ->
      expect(scope.events).toEqualData(events)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqualData({keywords: keywords})
