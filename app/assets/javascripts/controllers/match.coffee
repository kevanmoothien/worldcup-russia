angular.module('euro.controllers')
  .config ($stateProvider)->
    $stateProvider
    .state('matches', {
      url: '/matches?user_id',
      templateUrl: 'matches.html',
      controller: 'matchesController',
      params: {user_id: null}
      resolve:
        User: 'User'
        Match: 'Match'
        current_user: (User, $stateParams)->
          user = null
          if $stateParams.user_id == null
            user = User.current_user()
          else 
            user = User.find($stateParams.user_id)
          user
        matches: (current_user)->
          current_user.matches()
#          Match.all(current_user)

    })
    .state('match-new', {
      url: '/matches/new',
      templateUrl: 'match-new.html',
      controller: 'newMatchController',
      resolve:
        User: 'User'
        current_user: (User)->
          User.current_user()
        Team: 'Team'
        teams: (Team)->
          Team.all()
    })
  .controller 'matchesController', ($scope, current_user, matches, Match, ngDialog, Alert)->
    $scope.user = current_user
    $scope.matches = matches
    $scope.edit = false
    $scope.no_filter = false

    $scope.toggle_no_filter = ->
      $scope.no_filter = !$scope.no_filter

    $scope.greaterThan = ()=>
      (item) =>
        return true if $scope.no_filter
        dd = new Date(item['schedule'])
        dd.getTime() > last_week().getTime()

    $scope.filters = { }
    $scope.edit_mode = ->
      $scope.edit = true
      $scope.filters = {not_played: true}

    $scope.bet_all = ->
      $scope.edit = false
      Match.bulk_update_bet(matches).then (res)->
        if res
          Match.all(current_user).then (matches)->
            $scope.matches = matches
          new Alert('success', 'Bet has been successfully updated', 10000)
        $scope.filters = {}

    $scope.cancel_bet = ->
      $scope.edit = false
      $scope.filters = {}

    $scope.delete = (e, match)->
      e.preventDefault()
      if window.confirm('Are you sure')
        match.destroy().then (res)->
          new Alert('success', 'Delete successful', 10000)
          index = $scope.matches.indexOf(match)
          $scope.matches.splice(index, 1)
    
    $scope.update = (e, match)->
      ngDialog.open
        template: 'firstDialog'
        className: 'ngdialog-theme-default'
        scope: $scope
        data:
          match: match
    
    $scope.bet = (e, match)->
      ngDialog.open
        template: 'secondDialog'
        className: 'ngdialog-theme-default'
        scope: $scope
        data:
          match: match
          user_score_a: match.user_score_a
          user_score_b: match.user_score_b
    $scope.save = (e, match)->
      e.preventDefault()
      match.update().then((res)->
        ngDialog.close()
        new Alert('success', 'Match has been successfully updated', 10000)
        update_score()
      , (e)->
        new Alert('danger', 'Something went wrong. Please try again later', 10000)
      )
    $scope.save_bet = (e, match)->
      e.preventDefault()
      match.update_bet().then((res)->
        ngDialog.close()
        new Alert('success', 'Bet has been successfully updated', 10000)
        update_score()
      , (e)->
        $scope.$evalAsync ->
          match.user_score_a = null
          match.user_score_b = null
        new Alert('danger', 'Something went wrong. Please try again later', 10000)
      )
    $scope.$watch 'matches', ->
      update_score()
    , true
    update_score = ->
      $scope.scores = 0
      _.each $scope.matches, (match)->
        $scope.$evalAsync ->
          $scope.scores += match.score()
    last_week = ()->
      d = new Date()
      day = d.getDay()
      diff = d.getDate() - 7 # day + (if day == 0 then -6 else 1)
      new Date(d.setDate(diff))

  .controller 'newMatchController', ($scope, current_user, teams, Match, Alert)->
    $scope.user = current_user
    $scope.teams = teams
    
    $scope.new_matches = [{ teamA: null, teamB: null, time: null, final: false }]
    
    $scope.new_match = (e)->
      e.preventDefault()
      $scope.new_matches.push { teamA: null, teamB: null, time: null, final: false }
    $scope.remove = (e, item)->
      e.preventDefault()
      index = $scope.new_matches.indexOf(item)
      $scope.new_matches.splice(index, 1)

    $scope.openCalendar = (e, prop, match)->
      e.preventDefault()
      e.stopPropagation()
      match.isOpen = true

    $scope.save = (e)->
      e.preventDefault()
      Match.bulk_create($scope.new_matches).then (res)->
        $scope.new_matches = []
        new Alert('success', 'Match has been successfully created', 10000)
