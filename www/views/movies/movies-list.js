app.controller('MoviesListCtrl', function($scope, MoviesService, $ionicPopup, $ionicModal) {
	$scope.data = MoviesService.data;
	$scope.removeMovie = function(id) {

		var confirmPopup = $ionicPopup.confirm({
			title: 'Consume Ice Cream',
			template: 'Are you sure you want to eat this ice cream?'
		});

		confirmPopup.then(function(res) {
			if (res) {
				MoviesService.removeMovie(id);
			} else {
				console.log('You are not sure');
			}
		});
	};

	$scope.addMovie = function(form) {
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
		console.log("movies", $scope.data.movies);

		$scope.closeModal();
	};

	$ionicModal.fromTemplateUrl('views/movies/add-movie.html', {
		scope: $scope,
		animation: 'slide-in-up'
	}).then(function(modal) {
		$scope.modal = modal;
	});
	$scope.openModal = function() {
		$scope.modal.show();
	};
	$scope.closeModal = function() {
		$scope.modal.hide();
	};
	//Cleanup the modal when we're done with it!
	$scope.$on('$destroy', function() {
		$scope.modal.remove();
	});
	// Execute action on hide modal
	$scope.$on('modal.hidden', function() {
		// Execute action
	});
	// Execute action on remove modal
	$scope.$on('modal.removed', function() {
		// Execute action
	});


});
