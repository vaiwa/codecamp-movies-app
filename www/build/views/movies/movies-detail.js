(function() {
  app.controller('MoviesDetailCtrl', function($scope, MoviesService, $stateParams) {
    var movieId;
    if ($stateParams.id) {
      movieId = +$stateParams.id;
      $scope.movie = MoviesService.getMovieById(movieId);
    }
    $scope.isMovieWatched = function() {
      return MoviesService.isMovieWatched(movieId);
    };
    return $scope.toggleWatched = function() {
      return MoviesService.toggleWatched(movieId);
    };
  });

}).call(this);
