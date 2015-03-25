report = ->
	return if not $('body').hasClass('show')

	$report_btn = $('.report-btn');
	$report_modal_btn = $('.report-confirm-btn');

	$report_modal_btn.click( ->
		# Prepare AJAX call
		proj_id = $report_btn.data('project-id')
		req_data = { 'type': 'POST', 'data': { 'project_id': proj_id } }

		# Make AJAX call
		$.ajax('/report/project', req_data).success( ->
			# Hide 'Report Project' button
			$report_btn.fadeOut()
		)
	)

geo_community_selection = ->
	return if not $('body').hasClass('new')

	$table = $('.geo-communities')
	$country_selects = $('.country-select')
	$city_selects = $('.city-select')
	$add_row_btns = $('.add-geo-community-btn')
	$remove_row_btns = $('.remove-geo-community-btn')

	# Empty a city selector
	empty_cities = (sel) ->
		# Reset city selector
		sel.empty()
		$initial_option = $('<option></option>').text('----------')
		sel.append($initial_option)
		sel.prop('disabled', true)

	# Update the city selection options
	update_cities = (e) ->
		# Disable inputs
		$cur_country_select = $(e.target)
		$cur_country_select.prop('disabled', true)
		$cur_city_select = $cur_country_select.closest('tr').find('.city-select')
		$cur_city_select.prop('disabled', true)

		# Get list of cities
		req_data = { 'type': 'GET', 'data': { 'country_id': $cur_country_select.val() } }
		$.ajax('/location/cities', req_data).success((data) ->
			# Update city selector
			$cur_city_select.empty()
			$.each(data, (index, obj) ->
				console.log(obj)
				option = $('<option></option>').attr('value', obj['id']).text(obj['city'])
				$cur_city_select.append(option))

			# Add 'all cities' option
			$all_option = $('<option></option>').attr('value', '').text('ENTIRE COUNTRY')
			$cur_city_select.prepend(0, $all_option)

			# Reenable inputs
			$cur_country_select.prop('disabled', false)
			$cur_city_select.prop('disabled', false)
		).error( ->
			# Reenable country selector
			empty_cities($cur_city_select)
			$cur_country_select.prop('disabled', false))

	# Hide the remove buttons if there's only one row
	update_remove_button = ->
		if $('.geo-communities tr').length > 1
			$('.remove-geo-community-btn').show()
		else
			$('.remove-geo-community-btn').hide()

	# Add another row allowing the user to select multiple communities
	remove_row = (e) ->
		e.preventDefault()
		$row = $(e.target).closest('.location-select')
		$row.remove()
		update_remove_button()

	# Add another row allowing the user to select multiple communities
	add_row = (e) ->
		e.preventDefault()

		# Add row
		$lastrow = $('.geo-communities .location-select:last')
		$newrow = $lastrow.clone()
		empty_cities($newrow.find('.city-select'))
		$newrow.insertAfter($lastrow)

		# Register handlers
		$newrow.find('.remove-geo-community-btn').click(remove_row)
		$newrow.find('.country-select').change(update_cities)
		update_remove_button()

	# Register handlers
	$country_selects.change(update_cities)
	$add_row_btns.click(add_row)
	$remove_row_btns.click(remove_row)
	update_remove_button()

ready = ->
	return if not $('body').hasClass('projects')

	report()
	geo_community_selection()

$(document).ready(ready)
$(document).on('page:load', ready)
