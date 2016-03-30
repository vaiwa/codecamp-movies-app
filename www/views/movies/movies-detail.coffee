app.controller 'MoviesDetailCtrl', ($scope, MoviesService, $stateParams) ->
	if $stateParams.id
		movieId = +$stateParams.id
		$scope.movie = MoviesService.getMovieById(movieId)

	$scope.isMovieWatched = -> MoviesService.isMovieWatched(movieId)
	$scope.toggleWatched = -> MoviesService.toggleWatched(movieId)
