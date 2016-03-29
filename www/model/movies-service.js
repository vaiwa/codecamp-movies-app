app.factory('MoviesService', function ($http, APP_CONFIG) {
	return new (function () { // kvuli odstineni
		var service = this;
		service.data = {};

		service.getMovies = function (cb) {
			var req = {
				method: 'GET',
				url: APP_CONFIG.getApiUrl('moviesPopular')
			}
			$http(req)
			.success(function (response) {
				console.log(response);
				service.data.movies = response.results;

				if (cb) cb();
			})
			.error(function (data, status, headers, config) {
				console.error('error');
			});
		}

		service.getMovieById = function (id) {
			var result = {}
			angular.forEach(service.data.movies, function (movie) {
				if(movie.id == id) result = movie;
			})
			return result;
		};

		service.watchedMovies = []
		service.getWatchedMoviesFromStorage = function () {
			try {
				service.watchedMovies = JSON.parse(localStorage.getItem('watched_movies')) || [];
			} catch (e) {
				console.warn('bad json', e);
			}
			return service.watchedMovies;
		};

		service.toggleWatched = function (id) {
			var occurenceIndex = service.watchedMovies.indexOf(id);
			if (~occurenceIndex) {
				service.watchedMovies.splice(occurenceIndex, 1);
			} else {
				service.watchedMovies.push(+id);
			}
			localStorage.setItem('watched_movies', JSON.stringify(service.watchedMovies));
		};

		service.isMovieWatched = function (movieId) {
			return !!~service.watchedMovies.indexOf(movieId);
		};


		service.getMovies(function () {
			service.getWatchedMoviesFromStorage();
		});

		service.removeMovie = function (id) {
			angular.forEach(service.data.movies, function (movie, index) {
				if (movie.id === id) {
					service.data.movies.splice(index, 1);
				}
			});
		}

	})();
});