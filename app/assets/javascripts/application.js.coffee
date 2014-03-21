#= require jquery
#= require jquery_ujs

#= require angular
#= require angular-route
#= require setup

#= require_directory ./controllers
#= require_directory ./services

#= require foundation
#= require turbolinks
#= require_tree .

$ ->
  $(document).foundation()
  return

AngularBlog.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
  interceptor = ["$location", "$rootScope", "$q", ($location, $rootScope, $q) ->
    success = (response) ->
      response
    error = (response) ->
      if response.status is 401
        $rootScope.$broadcast "event:unauthorized"
        $q.reject response
    (promise) ->
      promise.then success, error
  ]
  $httpProvider.responseInterceptors.push interceptor
])


AngularBlog.config ["$routeProvider", ($routeProvider) ->
  $routeProvider.when("/",
    templateUrl: "/templates/Home/index.html"
    controller: 'HomeCtrl'
  ).when("/login",
    templateUrl: "/templates/Home/login.html"
    controller: 'LoginCtrl'
  ).when("/signup",
    templateUrl: "/templates/Home/index.html"
    controller: 'HomeCtrl'
  ).when("/profile",
    templateUrl: "/templates/profile/index.html"
    controller: 'ProfileCtrl'
  ).when("/logout",
    templateUrl: "/templates/Home/logout.html"
    controller: 'LogoutCtrl'
  ).when("/forgotpassword",
    templateUrl: "/templates/Home/forgotpassword.html"
    controller: 'ProfileCtrl'
  ).when("/resetpassword/:token",
    templateUrl: "/templates/Home/updatepassword.html"
    controller: 'ProfileCtrl'
  )
]
