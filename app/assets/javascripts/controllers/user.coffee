angular.module('euro.controllers')
  .config ($stateProvider)->
    $stateProvider
    .state('users', {
      url: '/users',
      templateUrl: 'user.html',
      controller: 'userController',
      resolve: 
        User: 'User'
        users: (User)->
          User.all()
    })
  .controller 'userController', ($scope, users, $filter)->
    $scope.users = []
    $scope.all_users = users
    $scope.$watch 'all_users', ->
      build()
    , true

    build = ->
      $scope.users = []
      users_group = $filter('reverse')($filter('toArray')($filter('groupBy')(users, 'score'), true))
      counter = 1
      previous_list_length = 0
      _.each users_group, (user_list)->
        $scope.$evalAsync ->
          $scope.users.push({rank: counter, users: user_list})
          previous_list_length = user_list.length
          counter = counter + previous_list_length
