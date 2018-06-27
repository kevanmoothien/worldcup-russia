angular.module('euro.services')
  .factory 'Match',
  ($http,
    $q,
    $filter,
    PaginationLoader,
    $rootScope
  )->
    class Match
      constructor: (data)->
        @id = data.id
        @team_a = data.team_a
        @team_b = data.team_b
        @score_a = data.score_a
        @score_b = data.score_b
        @schedule = data.schedule
        @user_score_a = data.user_score_a
        @user_score_b = data.user_score_b
        @not_played = Date.parse(@schedule) > Date.now()
        @date = $filter('date')(@schedule, "EEEE dd MMM yyyy")
        @final = data.final
      update: ->
        defer = $q.defer()
        $http.put("/api/v1/matches/#{@id}", {score_a: @score_a, score_b: @score_b }).then((res)->
          defer.resolve res
        , (err)->
          defer.reject err
        )
        defer.promise
      update_bet: ->
        defer = $q.defer()
        $http.post("/api/v1/matches/#{@id}/bets", {score_a: @user_score_a, score_b: @user_score_b }).then((res)->
          defer.resolve res
        , (err)->
          defer.reject err
        )
        defer.promise
      destroy: ->
        defer = $q.defer()
        $http.delete("/api/v1/matches/#{@id}").then (res)->
          defer.resolve res
        defer.promise
      score: ->
        sc = @calc_score()
        if @final
          sc = sc * 2
        sc
      calc_score: ->
        if @user_score_a == null || @user_score_b == null || @score_a == null || @score_b == null
          return 0
        #exact score prediction
        if @user_score_a == @score_a && @user_score_b == @score_b
          return 3
        #exact win prediction
        if @score_a > @score_b && @user_score_a > @user_score_b
          return 1
        if @score_a < @score_b && @user_score_a < @user_score_b
          return 1
        if @score_a == @score_b && @user_score_a == @user_score_b
          return 1
        return 0
      played: ->
        Date.parse(@schedule) < Date.now()
#    Match.all = (current_user)->
#      matches = []
#      promise = PaginationLoader(
#        (page)=>
#          $http.get("/api/v1/users/#{current_user.id}/matches?page=#{page}").then (res)->
#            res.data.matches
#        ,(results, page)=>
#          matches.length = 0 if page == 1
#          $rootScope.$evalAsync =>
#            _.each results, (match)=>
#              if Date.now() > Date.parse(match.schedule) && !current_user.me
#                matches.push(new Match(match))
#              else if current_user.me
#                matches.push(new Match(match))
#        , =>
#          matches
#      )
#      promise
    Match.bulk_create = (data)->
      defer = $q.defer()
      $http.post('/api/v1/matches', {infos: data}).then (res)->
        defer.resolve res
      defer.promise
    Match.bulk_update_bet = (data)->
      defer = $q.defer()
      updates = []
      _.each data, (item)->
        if item.played() && item.user_score_a? && item.user_score_b?
          match = {
            match_id: item.id,
            team_a: item.team_a.id,
            team_b: item.team_b.id,
            score_a: item.user_score_a,
            score_b: item.user_score_b
          }
          updates.push match
      $http.post('/api/v1/bets/bulk_update', {infos: updates}).then (res)->
        defer.resolve res
      defer.promise
    return Match