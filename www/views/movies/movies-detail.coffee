app.controller 'MoviesDetailCtrl', ($scope, MoviesService, $stateParams) ->
	if $stateParams.id
		movieId = +$stateParams.id
		$scope.movie = MoviesService.getMovieById movieId
		MoviesService.getMovieCredits movieId, (err, res) -> $scope.credits = res
		$scope.$on '$ionicView.enter', -> ga_storage._trackPageview '/movies/:movieId', 'Detail'

	$scope.isMovieWatched = -> MoviesService.isMovieWatched(movieId)
	$scope.toggleWatched = -> MoviesService.toggleWatched(movieId)
