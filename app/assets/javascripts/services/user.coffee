angular.module('euro.services')
  .factory 'User',
  ($http,
    $q,
    PaginationLoader,
    $rootScope,
    Match
  )->
    class User
      constructor: (data, me)->
        @id = data.id
        @admin = data.admin
        @username = data.username
        @email = data.email
        @score = data.score
        @me = me
      load_matches: ->
        @_matches = []
        promise = PaginationLoader(
          (page)=>
            $http.get("/api/v1/users/#{@id}/matches?page=#{page}").then (res)->
              res.data.matches
        ,(results, page)=>
          @_matches.length = 0 if page == 1
          $rootScope.$evalAsync =>
            _.each results, (match)=>
              if Date.now() > Date.parse(match.schedule) && !@me
                @_matches.push(new Match(match))
              else if @me
                @_matches.push(new Match(match))
        , =>
          @_matches
        )
        promise
      matches: ->
        return @_matches if @_matches?
        @load_matches()
        @_matches


    User.current_user = ->
      defer = $q.defer()
      $http.get('/api/v1/user/me').then (res)->
        user = new User(res.data.user, true)
        defer.resolve user
      defer.promise
    User.find = (id)->
      defer = $q.defer()
      $http.get("/api/v1/users/#{id}").then (res)->
        user = new User(res.data.user, false)
        defer.resolve user
      defer.promise
    User.all = ->
      defer = $q.defer()
      $http.get('/api/v1/users').then (res)->
        users = []
        _.each res.data.users, (user)->
          users.push(new User(user))
        defer.resolve users
      defer.promise
    return User