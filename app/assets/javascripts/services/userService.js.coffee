AngularBlogService.factory('User', ['$location', '$http', '$q', ($location, $http, $q)  ->

  password_reset: (user) ->
    deferred = $q.defer()
    $http.post('/api/passwords',
      user:
        email:
          user.email
    ).success((data) ->
      deferred.resolve(data)
    ).error((data) ->
      deferred.reject(data.error)
    )
    deferred.promise

  changePassword: (user) ->
    deferred = $q.defer()
    $http.put('/api/passwords',
      user:
        reset_password_token: user.reset_password_token,
        password: user.password,
        password_confirmation: user.confirmPassword
    ).success((data) ->
      deferred.resolve(data)
    ).error((data) ->
      deferred.reject(data.error)
    )
    deferred.promise

  updateProfile: (user) ->
    deferred = $q.defer()
    $http.put('/api/users',
      user:
        first_name: user.first_name
        last_name:  user.last_name,
    ).success((data) ->
      deferred.resolve(data)
    ).error((data) ->
      deferred.reject(data)
    )
    deferred.promise
])

