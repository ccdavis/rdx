# rdx
Redmine API example Ruby code

### Introduction

Redmine is an issue tracker web application written with Ruby on Rails.

This example will pull issues off a Redmine website using a user name / password and API key. It appears the API limits requests to fifty items or less.

Set your credentials in the 'config.rb' file. To use this code you must have an account on the Redmine site you're trying to access. Get your API key on the 'My Account' page once you have signed in.

Run with 	

	ruby test.rb
		
	Does not work with JRuby because of 'httparty' requirement. Requires 'active-model' and 'httparty' gems.
	
The 'json_formatter'	 code isn't used by the example, but it would be used in the alternative approach to accessing the Redmine API which requires 'active_resource'. The example now uses 'active_model' and the JSON serializer found there. Unfortunately, as of the last time I checked, the Redmine API documentation for accessing Redmine with Ruby shows hwo to do it with 'active_resource' which seems to be depricated at this point and doesn't appear to be the way forward. The 'active_resource' approach looks very apealing so that's a shame, but I don't know all the considerations that went into moving away from it.


### Using the Redmine API

You can retrieve issues in different orders and filter on different things. Here's the 'get' request that pulls down the data:

	response = 	get('/issues.json?assigned_to_id=me&sort=status_id&limit=100')
	
	
	