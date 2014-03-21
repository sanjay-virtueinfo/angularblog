AngularBlog.controller('HomeCtrl', ['$location','$scope', 'Session', ($location, $scope, Session) ->

  $scope.signupForm = {}

  $scope.signup = () ->
    u = $scope.signupForm
    Session.register(u.email, u.password, u.confirmPassword).then(
      (user)->
        $location.path '/profile/'
    , (error)->
      $scope.signUpError = error
    )
])
