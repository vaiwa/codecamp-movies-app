app.factory 'ContactsService', ($resource, APP_CONFIG, $q) ->
	service = @
	service.data = {}

	service.getContacts = (callback) ->
		options = new ContactFindOptions()
		options.filter = ''
		options.multiple = yes
		options.desiredFields = [
			navigator.contacts.fieldType.displayName
			navigator.contacts.fieldType.name
			navigator.contacts.fieldType.emails
		]

		promise = $q.defer()
		navigator.contacts.find ['*']
		, (contacts) ->
			filtered = _.filter contacts, (contact) -> contact?.name?.familyName and contact?.name?.givenName and contact?.emails?.length
			console.log 'filtered', filtered
			promise.resolve filtered
		, (e) ->
			console.error 'error', e
			promise.reject()
		, options
		promise.promise

	service
