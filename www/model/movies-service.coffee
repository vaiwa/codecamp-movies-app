app.factory 'MoviesService', ($resource, APP_CONFIG) ->
	service = @
	service.data = {}
	service.page = 1
	service.watchedMovies = []

	service.getMovies = (page, cb) ->
		url = APP_CONFIG.getApiUrl 'moviesPopular', {page}
		$resource url, {}, query: isArray: no
		.query (res) ->
			service.data.movies ?= []
			service.data.movies = service.data.movies.concat res.results
			cb() if cb

	service.getMovieById = (id) ->
		result = {}
		for movie in service.data.movies
			result = movie if movie.id is id
		result

	service.getMovieCredits = (id, done) ->
		url = APP_CONFIG.getMovieCreditsUrl id
		$resource url
		.get (res) -> done null, res

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

	service.loadMore = (cb) ->
		service.page += 1
		service.getMovies service.page, ->
			service.getWatchedMoviesFromStorage()
			cb()

	service.removeMovie = (id) ->
		for movie, index in service.data.movies or []
			service.data.movies.splice index, 1 if movie.id is id


	service.getMovies service.page, -> service.getWatchedMoviesFromStorage()
	service
