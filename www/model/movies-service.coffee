app.factory 'MoviesService', ($http, APP_CONFIG) ->

	service = @
	service.data = {}

	service.getMovies = (cb) ->
		req = method: 'GET', url: APP_CONFIG.getApiUrl 'moviesPopular'
		$http req
		.success (response) ->
			console.log response
			service.data.movies = response.results
			cb() if cb
		.error (data, status, headers, config) -> console.error 'error'

	service.getMovieById = (id) ->
		result = {}
		for movie in service.data.movies
			result = movie if movie.id is id
		result

	service.watchedMovies = []
	service.getWatchedMoviesFromStorage = ->
		try
			service.watchedMovies = JSON.parse(localStorage.getItem 'watched_movies') or []
		catch e
			console.warn 'bad json', e
		service.watchedMovies

	service.toggleWatched = (id) ->
		occurenceIndex = service.watchedMovies.indexOf id
		if ~occurenceIndex
			service.watchedMovies.splice occurenceIndex, 1
		else
			service.watchedMovies.push +id
		localStorage.setItem 'watched_movies', JSON.stringify service.watchedMovies

	service.isMovieWatched = (movieId) -> !!~service.watchedMovies.indexOf movieId


	service.getMovies -> service.getWatchedMoviesFromStorage()

	service.removeMovie = (id) ->
		for movie, index in service.data.movies or []
			service.data.movies.splice index, 1 if movie.id is id

	service


