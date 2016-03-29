app.controller('MoviesDetailCtrl', function ($scope, MoviesService, $stateParams) {
	if($stateParams.id) {
		var movieId = +$stateParams.id;
		$scope.movie = MoviesService.getMovieById(movieId);
	}

	$scope.isMovieWatched = function () {
		return MoviesService.isMovieWatched(movieId);
	}

	$scope.toggleWatched = function () {
		return MoviesService.toggleWatched(movieId);
	}

});
