app.factory 'MoviesService', ($http, APP_CONFIG) ->
	service = @
	service.data = movies: []
	service.page = 1

	service.getMovies = (page, cb) ->
		req = method: 'GET', url: APP_CONFIG.getApiUrl 'moviesPopular', {page}
		$http req
		.success (response) ->
			service.data.movies = service.data.movies.concat response.results
			cb() if cb
		.error (data, status, headers, config) -> console.error 'error'

	service.getMovieById = (id) ->
		result = {}
		for movie in service.data.movies
			result = movie if movie.id is id
		result

	service.getMovieCredits = (id, done) ->
		$http method: 'GET', url: APP_CONFIG.getMovieCreditsUrl id
		.success (response) -> done null, response
		.error (data, status, headers, config) -> done 'MovieCreditsError'

	service.watchedMovies = []
	service.getWatchedMoviesFromStorage = ->
		try
			service.watchedMovies = JSON.parse(localStorage.getItem 'watched_movies') or []
		catch e
			console.warn 'bad json', e
		service.watchedMovies

	service.toggleWatched = (id) ->
		if id in service.watchedMovies
			service.watchedMovies = _.without service.watchedMovies, id
		else
			service.watchedMovies.push +id
		localStorage.setItem 'watched_movies', JSON.stringify service.watchedMovies

	service.isMovieWatched = (movieId) -> movieId in service.watchedMovies


	service.getMovies service.page, -> service.getWatchedMoviesFromStorage()

	service.loadMore = (cb) ->
		service.page += 1
		service.getMovies service.page, ->
			service.getWatchedMoviesFromStorage()
			cb()

	service.removeMovie = (id) ->
		for movie, index in service.data.movies or []
			service.data.movies.splice index, 1 if movie.id is id

	service
