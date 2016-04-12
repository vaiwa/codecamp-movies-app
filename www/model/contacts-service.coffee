app.factory 'ContactsService', ($resource, APP_CONFIG, $q) ->
	service = @
	service.data = {}

	service.filterContacts = (contacts) ->
		ilteredContacts = []
		filteredContacts.push contact for contact in contacts when contact?.name?.familyName and contact?.name?.givenName and contact?.emails?.length
		filteredContacts

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
		navigator.contacts.find ['*'], (contacts) ->
			promise.resolve service.filterContacts contacts
		, (e) ->
			console.error 'error', e
			promise.reject()
		, options
		promise.promise

	service
