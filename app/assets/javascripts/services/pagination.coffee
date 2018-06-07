angular.module('euro.services')
  .factory 'PaginationLoader', ($q)->
    load_page = (load, callback, end_callback, defer, page = 1)->
      defer ||= $q.defer()
      load(page).then (results)->
        if results.length > 0
          callback(results, page)
          defer.notify({ page: page })
          load_page(load, callback, end_callback, defer, page+1)
        else
          if end_callback?
            defer.resolve(end_callback())
          else
            defer.resolve()
      return defer.promise
    return load_page