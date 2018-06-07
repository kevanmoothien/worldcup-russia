angular.module('euro.controllers')
  .config ($stateProvider)->
    $stateProvider
    .state('bet', {
      url: '/bet',
      templateUrl: 'bet.html',
      controller: 'betController'
    })
  .controller 'betController', ($scope)->
    console.log 'bet'