app.factory 'GlobalService', ($http, $ionicPopup, APP_CONFIG) ->
	self = @
	@.promises = []
	@.data = {}


	# Method for pushing promises to array for getting know what resources aren't loaded
	@.pushPromise = (promise) -> self.promises.push promise.$promise

	# Show spinner until all content in the view are loaded
	@.startLoading = (promise) ->
		self.loadingShow()
		$q.all @.promises
		.then ->
			self.loadingHide()
			self.promises = []
		, ->
			self.loadingHide()

	# Method for showing custom spinner
	@.loadingShow = (text = 'Loading data') ->
		$ionicLoading.show template: "<ion-spinner></ion-spinner><br><span>#{text}</span>"

	# Method for hiding custom spinner
	@.loadingHide = -> $ionicLoading.hide()

	# Method for showing custom dialog
	@.dialogShow = (text = 'Loading data', title, duration = 2000, classes = 'ion-ios-checkmark-empty zoom-in') ->
		title = if title then '<span class="title">' + title + '</span>' else ''
		$ionicLoading.show
			template: '<i class="button-icon icon assertive animation ' + classes + '"></i><div class="box">' + title + text + '</div>',
			duration: duration

	###
	Get data for dataSource from the server
	@param {object} service
	@param {object} options
	 *	{function} options.callback
	 *	{object} options.customDataSource - $resource object which will be downloaded and cached
	 *	{string} options.customTarget - Target where to map data. Example: for string "campaigns" data are mapped to service.data.campaigns
	 *	{object} options.queryParams - Specify what exactly should be picked from data source. For example in case of {userId: 123} will be picked only items with @ parameter
	 *
	###
	@.getRemoteContent = (service, options) ->
		dataSource = service.dataSource
		dataSource = options.customDataSource if options and options.customDataSource
		param = if options?.queryParams then options.queryParams else {}
		promise = dataSource.get(param, (response) ->
		).$promise
		self.pushPromise promise
		self.startLoading()
		promise



	# Get data from data source by specific ID
	@.getDataById = (dataSource, id, cb) ->
		state = null
		console.warn 'Empty data source' unless dataSource
		if dataSource instanceof Array
			for item, key of dataSource
				state = item if item.id is id
		else if dataSource?.id is id
			state = dataSource

		cb state if cb
		state


	# Get today date in YYYY-MM-DD
	@.getTodayDate = -> moment().format 'YYYY-MM-DD'


	# Get today date in timestamp
	@.getTodayTime = (date) -> moment(date, 'YYYY-MM-DD').unix()

	###
	@description Method for setting localstorage value with prefixed key
	@param {String} key name without prefix
	@param {String} value to be set into localStorage
	###
	@.setStorageItem = (key, value) -> localStorage.setItem APP_CONFIG.storagePrefix + key, value

	###
	@description Method for getting localStorage value with prefixed key
	@param {String} Key to search for
	###
	@.getStorageItem = (key) -> localStorage.getItem APP_CONFIG.storagePrefix + key

	###
	@description Method for remove localStorage value with prefixed key
	@param {String} Key to search for
	###
	@.removeStorageItem = (key) -> localStorage.removeItem APP_CONFIG.storagePrefix + key
