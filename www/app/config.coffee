app.constant 'APP_CONFIG',

	#Basic config
	debugMode: yes
	storagePrefix: 'test_'

	# API config
	apiKey: '4aa883f95999ec813b8bfaf319f3972b'
	apiUrl: 'api.themoviedb.org/3'
	apiEndpoints:
		moviesPopular: 'movie/popular'

	getApiUrl: (endpoint, params) ->
		url = "http://#{@.apiUrl}/#{@.apiEndpoints[endpoint]}?api_key=#{@.apiKey}"
		url += "&#{key}=#{value}" for key, value of params or {}
		url

	getMovieCreditsUrl: (movieId) -> "http://#{@.apiUrl}/movie/#{movieId}/credits?api_key=#{@.apiKey}"
	getMovieIdUrl: (movieId) -> "http://#{@.apiUrl}/movie/#{movieId}?api_key=#{@.apiKey}"

