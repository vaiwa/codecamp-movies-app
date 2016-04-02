app.controller 'MoviesListCtrl', ($scope, MoviesService, GlobalService, $ionicPopup, $ionicModal, $ionicSlideBoxDelegate) ->

	$scope.data = MoviesService.data
	$scope.removeMovie = (id) ->

		confirmPopup = $ionicPopup.confirm
			title: 'Remove'
			template: 'Are you sure you want to remove this movie?'

		confirmPopup.then (res) ->
			return MoviesService.removeMovie id if res
			console.log 'You are not sure'

	$scope.addMovie = (form) ->
		movies = $scope.data.movies
		lastMovie = movies[movies.length - 1]
		newId = lastMovie.id + 1
		newMovie =
			id: newId
			title: form.title
			release_date: moment(form.release_date).format 'YYYY-MM-DD'
			vote_average: '0'
			vote_count: '0'
		$scope.data.movies.push newMovie
		$scope.closeAddMovieModal()

	$ionicModal.fromTemplateUrl 'views/movies/add-movie.html', scope: $scope, animation: 'slide-in-up'
	.then (modal) -> $scope.addMovieModal = modal
	$scope.openAddMovieModal = -> $scope.addMovieModal.show()
	$scope.closeAddMovieModal = -> $scope.addMovieModal.hide()
	$scope.$on '$destroy', -> $scope.addMovieModal.remove() # Cleanup the modal when we're done with it!

	$ionicModal.fromTemplateUrl 'views/movies/tutorial.html', scope: $scope, animation: 'slide-in-up'
	.then (modal) -> $scope.tutorialModal = modal
	$scope.openTutorialModal = -> $scope.tutorialModal.show()
	$scope.closeTutorialModal = -> $scope.tutorialModal.hide()
	$scope.$on '$destroy', -> $scope.tutorialModal.remove() # Cleanup the modal when we're done with it!

	$scope.tutorialSlide = (index) -> $ionicSlideBoxDelegate.slide index, 100

	$scope.loadMore = -> MoviesService.loadMore -> $scope.$broadcast 'scroll.infiniteScrollComplete'
	$scope.$on '$stateChangeSuccess', -> $scope.loadMore()
