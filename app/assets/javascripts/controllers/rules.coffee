angular.module('euro.controllers')
.config ($stateProvider)->
  $stateProvider
  .state('rules', {
    url: '/rules',
    templateUrl: 'rule.html',
    controller: 'ruleController',
  })
.controller 'ruleController', ($scope)->