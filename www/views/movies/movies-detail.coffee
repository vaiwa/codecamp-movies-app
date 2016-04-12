
app.controller 'MoviesDetailCtrl', ($scope, MoviesService, GlobalService, ContactsService, $ionicModal, $stateParams) ->
	if $stateParams.id
		movieId = +$stateParams.id

		MoviesService.getMovies ->
			$scope.movie = MoviesService.getMovieById movieId

		MoviesService.getMovieCredits movieId, (err, res) -> $scope.credits = res
		MoviesService.getMovieInfo movieId, (err, res) ->
			$scope.countries = res.production_countries

			google.charts.load 'current', 'packages': ['geochart']
			google.charts.setOnLoadCallback ->
				countries = [ ['Country', 'Popularity'] ]
				countries.push [country.iso_3166_1, 500] for country in $scope.countries

				data = google.visualization.arrayToDataTable countries
				options = dataMode: 'regions'

				container = document.getElementById 'regions_div'
				geochart = new google.visualization.GeoChart container

				geochart.draw data, options

		$scope.$on '$ionicView.enter', -> ga_storage._trackPageview '/movies/:movieId', 'Detail'

	$ionicModal.fromTemplateUrl 'views/contacts/contacts-modal.html', scope: $scope, animation: 'slide-in-up'
	.then (modal) -> $scope.contactsModal = modal

	$scope.share = (type) ->
		switch type
			when 'twitter'
				console.log 'twitter'
				window.plugins.socialsharing.shareViaTwitter "I love this movie: #{$scope.movie.title}"
			when 'email'
				console.log 'email'
				GlobalService.loadingShow()
				ContactsService.getContacts().then (contacts) ->
					console.log 'contacts', contacts
					$scope.contacts = contacts
					$scope.contactsModal.show()
					GlobalService.loadingHide()

			else console.warn 'WrongType'

	$scope.shareOnEmail = (contact) ->
		message = 'Dear '+contact.name.familyName+',\nI love this movie!! <3 '+ $scope.movie.title+''
		window.plugins.socialsharing.shareViaEmail message, # can contain HTML tags, but support on Android is rather limited:  http://stackoverflow.com/questions/15136480/how-to-send-html-content-with-image-through-android-default-email-client
			'Subject',
			[contact.emails[0].value], # TO: must be null or an array
			null, # BCC: must be null or an array
			null, # FILES: can be null, a string, or an array
			-> # Success callback
				$scope.contactsModal.hide()

	$scope.isMovieWatched = -> MoviesService.isMovieWatched(movieId)
	$scope.toggleWatched = -> MoviesService.toggleWatched(movieId)
