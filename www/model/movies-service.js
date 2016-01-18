app.factory('MoviesService', function ($rootScope, $http, $state, $ionicLoading) {
    return new (function () {
        var service = this;
        service.data = {};
        service.data.movies = [
            {
                "Title": "Inglourious Basterds",
                "Year": "2009",
                "imdbID": "tt0361748",
                "Type": "movie"
            },
            {
                "Title": "Pulp Fiction",
                "Year": "1994",
                "imdbID": "tt0110912",
                "Type": "movie"
            },
        ]
    })();
});
