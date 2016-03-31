app.controller 'MainCtrl', ($scope, $state, $ionicNavBarDelegate, $ionicPopup, $ionicModal, $filter, $interval, GlobalService, $rootScope, $ionicLoading, $ionicSideMenuDelegate, $ionicHistory, $ionicScrollDelegate, APP_CONFIG) ->
	$scope.config = APP_CONFIG
	$scope.debugMode = APP_CONFIG.debugMode
	$scope.applicationStatus = null

	$scope.$on 'applicationStatus', (event, applicationStatus) ->
		$scope.applicationStatus = applicationStatus


	###
	@description Universal alert dialog
	@param {string} alert text
	@param {string} alert title
	@param {string} alert button text
	@param {function} alert callback
	###
	$rootScope.showAlert = (text, title, button, callback) ->
		button = 'Zavřít' unless button?
		title = 'Oznámení' unless title?
		if navigator.notification
			navigator.notification.alert text, callback, title, button
		else
			alert text


	###
	@description Method for skipping view and showing side menu button instead of back button
	###
	$scope.skipView = ->
		$ionicHistory.nextViewOptions
			disableBack: yes


	###
	@description Return true if the app is deploy on real device/simulator
	###
	$scope.isDevice = -> !!((ionic.Platform.isIPad() or ionic.Platform.isIOS() or ionic.Platform.isAndroid()) and window.cordova isnt undefined)



