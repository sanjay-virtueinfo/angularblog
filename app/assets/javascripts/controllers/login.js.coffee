AngularBlog.controller('LoginCtrl', ['$location','$scope', 'Session', ($location, $scope, Session) ->

  $scope.loginForm = {}

  $scope.login = (user) ->
    u = $scope.loginForm
    $scope.authError = null
    Session.login(u.email, u.password).then ((user) ->
      $location.path '/profile/'
    ), (error) ->
      $scope.loginError = error
])
