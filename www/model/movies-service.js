app.factory('MoviesService', function ($rootScope, $http, $state, $ionicLoading) {
    return new (function () {
        var service = this;
        service.data = {};
        service.data.movies = [
            {
                "title": "The Hateful Eight",
                "release_date": "2015-12-25",
                "vote_average": "7.12",
                "vote_count": "497"

            },
            {
                "title": "The Revenant",
                "release_date": "2015-12-25",
                "vote_average": "7.2",
                "vote_count": "507"
            },
        ]
    })();
});
