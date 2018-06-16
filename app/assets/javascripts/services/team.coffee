angular.module('euro.services')
  .factory 'Team',
  ($http,
    $q,
    PaginationLoader,
    $rootScope,
    Match
  )->
    class Team
      constructor: (data)->
        @id = data.id
        @image = data.image
        @name = data.name
        @api = data.api_name
        @flag = data.flag
        matches_data = []
        _.each data.matches, (match)->
          matches_data.push(new Match(match))
        @matches = matches_data
    teams = []
    Team.load_all = ->
#      teams = []
      promise = PaginationLoader(
        (page)=>
          $http.get('/api/v1/teams/?page='+page).then (res)->
            res.data.teams
        ,(results, page)=>
          teams.length = 0 if page == 1
          $rootScope.$evalAsync =>
            _.each results, (result)=>
              teams.push(new Team(result))
        , =>
          teams
      )
      promise
    Team.all = ->
      Team.load_all()
      teams
    return Team