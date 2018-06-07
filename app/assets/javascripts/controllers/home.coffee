angular.module('euro.controllers')
  .config ($stateProvider)->
    $stateProvider
    .state('home', {
      url: '/',
      templateUrl: 'home.html',
      controller: 'homeController'
    })
  .controller 'homeController', ($scope,$state)->
    $state.go('matches', {}, { location: 'replace' })