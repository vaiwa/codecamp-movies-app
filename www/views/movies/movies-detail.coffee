app.controller 'MoviesDetailCtrl', ($scope, MoviesService, $stateParams) ->
	if $stateParams.id
		movieId = +$stateParams.id
		$scope.movie = MoviesService.getMovieById movieId
		MoviesService.getMovieCredits movieId, (err, res) -> $scope.credits = res
		MoviesService.getMovieInfo movieId, (err, res) ->
			$scope.countries = res.production_countries

			google.charts.load 'current', 'packages': ['geomap']
			google.charts.setOnLoadCallback ->
				countries = [ ['Country', 'Popularity'] ]
				countries.push [country.iso_3166_1, 500] for country in $scope.countries

				data = google.visualization.arrayToDataTable countries
				options = dataMode: 'regions'

				container = document.getElementById 'regions_div'
				geomap = new google.visualization.GeoMap container

				geomap.draw data, options

		$scope.$on '$ionicView.enter', -> ga_storage._trackPageview '/movies/:movieId', 'Detail'

	$scope.isMovieWatched = -> MoviesService.isMovieWatched(movieId)
	$scope.toggleWatched = -> MoviesService.toggleWatched(movieId)
