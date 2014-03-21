AngularBlog.controller('ProfileCtrl', ['$location','$scope', '$routeParams', '$timeout', 'Session', 'User', ($location, $scope, $routeParams, $timeout, Session, User) ->
  $scope.user = null
  $scope.resetModel = profileModel = {}

  if $routeParams.token != null
    $scope.resetModel.reset_password_token = $routeParams.token


  Session.getCurrentUser().then((user)->
      $scope.user = user["data"]["user"]
    )

  $scope.forgotpassword = () ->
    User.password_reset($scope.forgotpasswordForm).then((data) ->
      $scope.forgotpasswordError = null
      $scope.flash_message = 'Email sent with password reset instructions.'
      window.setTimeout(() ->
        $scope.flash_message = null
        $scope.$digest()
      , 5000)
    , (data) ->
      $scope.forgotpasswordError = data
    )

  $scope.changePassword = () ->
    User.changePassword($scope.resetModel).then((data) ->
      $scope.flash_message = 'Your password has been changed.'
      $timeout (->
          $scope.flash_message = null
          $location.path '/profile/'
        ), 1500
    , (data) ->
      $scope.resetpasswordFormError = data
    )

  $scope.updateProfile = () ->
    User.updateProfile($scope.profileModel).then((data) ->
      $scope.flash_message = "Profile update successfully."
      $timeout (->
          $scope.flash_message = null
          $location.path '/profile/'
        ), 1500
    , (data) ->
      $scope.profileFormError = data
    )

])
