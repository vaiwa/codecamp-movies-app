app.factory('MoviesService', function() {
	return new (function() { // kvuli odstineni
		var service = this;
		service.data = {};
		service.data.movies = [
			{
				id: 1,
				title: 'top rated',
				release_date: '2015-12-25',
				vote_average: '7.12',
				vote_count: '497'
			},
			{
				id: 2,
				title: 'az film',
				release_date: '2015-11-25',
				vote_average: '4.12',
				vote_count: '297'
			},
			{
				id: 3,
				title: 'movie',
				release_date: '2014-11-25',
				vote_average: '5.12',
				vote_count: '297'
			},
			{
				id: 3,
				title: 'nejnovejsi',
				release_date: '2016-01-25',
				vote_average: '5.12',
				vote_count: '297'
			}
		]

		service.removeMovie = function(id) {
			angular.forEach(service.data.movies, function (movie, index) {
				if (movie.id === id) {
					service.data.movies.splice(index, 1);
				}
			});
		}

	})();
});