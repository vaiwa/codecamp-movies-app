app.config(function ($stateProvider, $urlRouterProvider, $ionicConfigProvider, $httpProvider, $resourceProvider, APP_CONFIG) {
    $httpProvider.interceptors.push('authInterceptorService');

    $stateProvider
        .state('movies', {
            url: '/movies',
            templateUrl: "views/movies/movies-list.html",
            controller: 'MoviesListCtrl'
        })
        // states end
    ;

    $urlRouterProvider.otherwise("/movies");

});
