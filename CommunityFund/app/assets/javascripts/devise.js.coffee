# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

geo_community_selection = ->
	$country_select = $('.country-select')
	$city_select = $('.city-select')

	# Empty a city selector
	empty_cities = (sel) ->
		# Reset city selector
		sel.empty()
		$initial_option = $('<option></option>').text('Select City')
		sel.append($initial_option)
		sel.prop('disabled', true)

	# Update the city selection options
	update_cities = (e) ->
		# Disable inputs
		$country_select.prop('disabled', true)
		$city_select.prop('disabled', true)

		# Get list of cities
		req_data = { 'type': 'GET', 'data': { 'country_id': $country_select.val() } }
		$.ajax('/location/cities', req_data).success((data) ->
			# Update city selector
			$city_select.empty()
			$.each(data, (index, obj) ->
				option = $('<option></option>').attr('value', obj['id']).text(obj['city'])
				$city_select.append(option))

			# Reenable inputs
			$country_select.prop('disabled', false)
			$city_select.prop('disabled', false)
		).error( ->
			# Reenable country selector
			empty_cities($city_select)
			$country_select.prop('disabled', false))

	# Register handlers
	$country_select.change(update_cities)


#fancy validators for username, email and password
#every single time there is a text input, try to validate and give feedback to user
#todo: make it turn to fail state when user deletes input after getting to a success state
ready = ->
  geo_community_selection()

  jQuery ->
    submit_show = () ->
      $('#signup_button').show()
      undefined
    #Returns true if all of the fields are in the success state
    all_ready = () ->
      username = $('#signup-username-input').val()
      email = $('#signup-email-input').val()
      password = $('#signup-password-input').val()
      password_confirm = $('#signup-password-confirm-input').val()
      re = /\S+@\S+\.\S+/
      if (username.length > 5) and re.test(email) == true and (password.length > 7) and (password_confirm == password)
        true
      else
        false

    $('#signup-username-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if value is over 5
      if value.length > 5
        $("#signup-username").attr("class","form-group has-success")
        $("#signup-username-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
          undefined
      else if value != ""
        $("#signup-username").attr("class","form-group has-error")
        $("#signup-username-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

    $('#signup-email-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if it fits a nice email regex
      re = /\S+@\S+\.\S+/
      if re.test(value) == true
        $("#signup-email").attr("class","form-group has-success")
        $("#signup-email-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
      else if value != ""
        $("#signup-email").attr("class","form-group has-error")
        $("#signup-email-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

    $('#signup-password-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if password is 7 chars long
      if value.length > 7
        $("#signup-password").attr("class","form-group has-success")
        $("#signup-password-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
      else if value != ""
        $("#signup-password").attr("class","form-group has-error")
        $("#signup-password-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

    $('#signup-password-confirm-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if password confirm is the same as password
      if $('#signup-password-input').val() == value and value != ""
        $("#signup-password-confirm").attr("class","form-group has-success")
        $("#signup-password-confirm-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
      else if value != ""
        $("#signup-password-confirm").attr("class","form-group has-error")
        $("#signup-password-confirm-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

  # validation for login page
  jQuery ->
    submit_show = () ->
      $('#login_button').show()
      undefined
    #Returns true if all of the fields are in the success state
    all_ready = () ->
      username = $('#login-username-input').val()
      password = $('#login-password-input').val()
      re = /\S+@\S+\.\S+/
      if (username.length > 5) and (password.length > 7)
        true
      else
        false

    $('#login-username-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if value is over 5
      if value.length > 5
        $("#login-username").attr("class","form-group has-success")
        $("#login-username-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
          undefined
      else if value != ""
        $("#login-username").attr("class","form-group has-error")
        $("#login-username-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

    $('#login-password-input').bind 'input', (->
      value = $(this).val() # get the current value of the input field.
      #change warning to success if password is 7 chars long
      if value.length > 7
        $("#login-password").attr("class","form-group has-success")
        $("#login-password-icon").attr("class","glyphicon glyphicon-ok form-control-feedback")
        if all_ready()
          submit_show()
      else if value != ""
        $("#login-password").attr("class","form-group has-error")
        $("#login-password-icon").attr("class","glyphicon glyphicon-remove form-control-feedback"))
    .trigger('input');

  #Submit buttons

    $(document).ready ->
      $('#signup_button').hide()
      undefined

    $(document).ready ->
      $('#login_button').hide()
      undefined

$(document).ready(ready)
$(document).on('page:load', ready)
