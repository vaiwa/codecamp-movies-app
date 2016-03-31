app.config ($stateProvider, $urlRouterProvider, $ionicConfigProvider, $httpProvider, $resourceProvider, APP_CONFIG) ->

	$httpProvider.interceptors.push 'authInterceptorService'

	$stateProvider
		.state 'movies',
			url: '/movies'
			templateUrl: 'views/movies/movies-list.html'
			controller: 'MoviesListCtrl'

		.state 'movies-detail',
			url: '/movies/:id'
			templateUrl: 'views/movies/movies-detail.html'
			controller: 'MoviesDetailCtrl'

	$urlRouterProvider.otherwise '/movies'