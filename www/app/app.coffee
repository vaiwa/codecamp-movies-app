
@.app = angular.module 'App', ['ionic', 'ngCordova', 'ui.router', 'ngResource']
	.run ($ionicPlatform, $http, $ionicSideMenuDelegate, $ionicScrollDelegate, $rootScope) ->
		$http.defaults.headers.post =
			'Content-Type': 'application/json'
			'Accept': 'application/json'
			'dataType': 'json'

		# Workaround for closing side menu in Android
		document.addEventListener 'touchstart', (event) ->
			event.preventDefault() if $ionicSideMenuDelegate.isOpenLeft()

		# DEVICE READY
		$ionicPlatform.ready ($cordovaGlobalization) ->
			setTimeout ->
				navigator.splashscreen and navigator.splashscreen.hide()
			, 100
			console.info 'DEVICE READY'
			if window.cordova and window.cordova.plugins.Keyboard
				try
					cordova.plugins.Keyboard.hideKeyboardAccessoryBar no
					cordova.plugins.Keyboard.disableScroll yes
				catch e
					console.error 'Hide keyboard fail'
			StatusBar.styleLightContent() if window.StatusBar

	.factory 'authInterceptorService', ['$q', '$location', '$window', '$injector', ($q, $location, $window, $injector) ->
		responseError = (rejection) ->
			$injector.get('$rootScope').$broadcast 'applicationStatus', 'unauthorized' if rejection.status is 401
			$q.reject rejection
		{responseError}
	]
