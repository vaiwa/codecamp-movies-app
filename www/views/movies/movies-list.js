app.controller('MoviesListCtrl', function($scope, MoviesService, $ionicPopup, $ionicModal) {
	$scope.data = MoviesService.data;
	$scope.removeMovie = function(id){

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

	}

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
