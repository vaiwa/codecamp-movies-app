(function() {
  app.controller('MoviesListCtrl', function($scope, MoviesService, $ionicPopup, $ionicModal, $ionicSlideBoxDelegate) {
    $scope.data = MoviesService.data;
    $scope.removeMovie = function(id) {
      var confirmPopup;
      confirmPopup = $ionicPopup.confirm({
        title: 'Consume Ice Cream',
        template: 'Are you sure you want to eat this ice cream?'
      });
      return confirmPopup.then(function(res) {
        if (res) {
          return MoviesService.removeMovie(id);
        } else {
          return console.log('You are not sure');
        }
      });
    };
    $scope.addMovie = function(form) {
      var lastMovie, movies, newId, newMovie;
      movies = $scope.data.movies;
      lastMovie = movies[movies.length - 1];
      newId = lastMovie.id + 1;
      newMovie = {
        id: newId,
        title: form.title,
        release_date: form.release_date,
        vote_average: '0',
        vote_count: '0'
      };
      $scope.data.movies.push(newMovie);
      return $scope.closeAddMovieModal();
    };
    $ionicModal.fromTemplateUrl('views/movies/add-movie.html', {
      scope: $scope,
      animation: 'slide-in-up'
    }).then(function(modal) {
      return $scope.addMovieModal = modal;
    });
    $scope.openAddMovieModal = function() {
      return $scope.addMovieModal.show();
    };
    $scope.closeAddMovieModal = function() {
      return $scope.addMovieModal.hide();
    };
    $scope.$on('$destroy', function() {
      return $scope.addMovieModal.remove();
    });
    $ionicModal.fromTemplateUrl('views/movies/tutorial.html', {
      scope: $scope,
      animation: 'slide-in-up'
    }).then(function(modal) {
      return $scope.tutorialModal = modal;
    });
    $scope.openTutorialModal = function() {
      return $scope.tutorialModal.show();
    };
    $scope.closeTutorialModal = function() {
      return $scope.tutorialModal.hide();
    };
    $scope.$on('$destroy', function() {
      return $scope.tutorialModal.remove();
    });
    return $scope.tutorialSlide = function(index) {
      return $ionicSlideBoxDelegate.slide(index, 100);
    };
  });

}).call(this);
