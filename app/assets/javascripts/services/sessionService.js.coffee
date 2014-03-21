AngularBlogService.factory('Session', ['$location','$http','$q', ($location, $http, $q) ->

  _currentUser = null

  login: (email, password) ->
    deferred = $q.defer()
    $http.post('/api/sessions',
      user:
        email: email
        password: password
    ).success((data)->
      _currentUser = data.user
      deferred.resolve(_currentUser)
    ).error((data) ->
      deferred.reject(data.error)
    )
    deferred.promise

  logout: () ->
    deferred = $q.defer()
    $http.delete("/api/sessions").then ->
      _currentUser = null
      deferred.resolve()
    deferred.promise

  register: (email, password, confirmPassword) ->
    deferred = $q.defer()
    $http.post('/api/users',
      user:
        email: email
        password: password
        password_confirmation: confirmPassword
    ).success((data) ->
      if data.id
        _currentUser = data
        deferred.resolve(_currentUser)
      else
        deferred.reject(data)
    ).error((data) ->
      deferred.reject(data)
    )
    deferred.promise

  logout: () ->
    deferred = $q.defer()
    $http.delete("/api/sessions").then ->
      _currentUser = null
      deferred.resolve()
    deferred.promise

  getCurrentUser: () ->
    deferred = $q.defer()
#    if !forceUpdate && this.isAuthenticated()
#      deferred.resolve(_currentUser)
#    else
    $http.get('/api/users').success((data)->
      data.user.sign_in_count = data.sign_in_count
      _currentUser = data.user
      deferred.resolve(_currentUser)
    ).error((data)->
      deferred.reject(data)
    )
#    deferred.promise


])
