app.controller('MoviesListCtrl', function ($scope, MoviesService, $ionicPopup, $ionicModal, $ionicSlideBoxDelegate) {
	$scope.data = MoviesService.data;
	$scope.removeMovie = function (id) {

		var confirmPopup = $ionicPopup.confirm({
			title: 'Consume Ice Cream',
			template: 'Are you sure you want to eat this ice cream?'
		});

		confirmPopup.then(function (res) {
			if (res) {
				MoviesService.removeMovie(id);
			} else {
				console.log('You are not sure');
			}
		});
	};

	$scope.addMovie = function (form) {
		movies = $scope.data.movies
		lastMovie = movies[movies.length - 1];
		newId = lastMovie.id + 1;
		var newMovie = {
			id: newId,
			title: form.title,
			release_date: form.release_date, // moment.js needed TODO
			vote_average: '0',
			vote_count: '0'
		}
		$scope.data.movies.push(newMovie);
		// console.log('movies', $scope.data.movies);

		$scope.closeAddMovieModal();
	};

	$ionicModal.fromTemplateUrl('views/movies/add-movie.html', {
		scope: $scope,
		animation: 'slide-in-up'
	}).then(function (modal) {
		$scope.addMovieModal = modal;
	});
	$scope.openAddMovieModal = function () {
		$scope.addMovieModal.show();
	};
	$scope.closeAddMovieModal = function () {
		$scope.addMovieModal.hide();
	};
	//Cleanup the modal when we're done with it!
	$scope.$on('$destroy', function () {
		$scope.addMovieModal.remove();
	});
	// Execute action on hide modal
	$scope.$on('modal.hidden', function () {
		// Execute action
	});
	// Execute action on remove modal
	$scope.$on('modal.removed', function () {
		// Execute action
	});

	$ionicModal.fromTemplateUrl('views/movies/tutorial.html', {
		scope: $scope,
		animation: 'slide-in-up'
	}).then(function (modal) {
		$scope.tutorialModal = modal;
	});
	$scope.openTutorialModal = function () {
		$scope.tutorialModal.show();
	};
	$scope.closeTutorialModal = function () {
		$scope.tutorialModal.hide();
	};
	//Cleanup the modal when we're done with it!
	$scope.$on('$destroy', function () {
		$scope.tutorialModal.remove();
	});
	// Execute action on hide modal
	$scope.$on('modal.hidden', function () {
		// Execute action
	});
	// Execute action on remove modal
	$scope.$on('modal.removed', function () {
		// Execute action
	});

	$scope.tutorialSlide = function (index) {
		$ionicSlideBoxDelegate.slide(index, 100);
	}


});
