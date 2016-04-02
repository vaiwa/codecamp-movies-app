app.constant 'APP_CONFIG',

	#Basic config
	debugMode: true
	storagePrefix: 'test_'

	# API config
	apiKey: '4aa883f95999ec813b8bfaf319f3972b'
	apiUrl: 'api.themoviedb.org/3/'
	apiEndpoints:
		moviesPopular: 'movie/popular'

	getApiUrl: (endpoint, params) ->
		url = "http://#{this.apiUrl}#{this.apiEndpoints[endpoint]}?api_key=#{this.apiKey}"
		url += "&#{key}=#{value}" for key, value of params or {}
		url
