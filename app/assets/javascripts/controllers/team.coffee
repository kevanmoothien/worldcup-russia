angular.module('euro.controllers')
  .config ($stateProvider)->
    $stateProvider
    .state('teams', {
      url: '/teams',
      templateUrl: 'team.html',
      controller: 'teamController',
      resolve: 
        Team: 'Team'
        teams: (Team)->
          Team.all()
    })
  .controller 'teamController', ($scope, teams)->
    $scope.teams = teams
    $scope.set_active = (api)->
      if $scope.team_active == api
        $scope.$evalAsync ->
          $scope.team_active = '###'
      $scope.team_active = api