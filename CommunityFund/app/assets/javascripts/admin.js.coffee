settings = ->
	return if not $('body').hasClass('settings')

	# Disable remove buttons if there's more than one row
	updateRemoveBtns = ->
		if $('.admin-user').length <= 1
			$('.remove-admin-btn').prop('disabled', true);
		else
			$('.remove-admin-btn').prop('disabled', false);
	updateRemoveBtns()

	# Remove the current row
	removeBtnClickHandler = ->
		$(this).closest('tr').remove()
		updateRemoveBtns()
	$('.remove-admin-btn').click(removeBtnClickHandler)

	# Add new row to the table
	$('.make-admin-btn').click( ->
		username = $('#make-admin-input').val()
		$('#make-admin-input').val('')
		$lastrow = $('.admin-users .admin-user:last')
		$newrow = $lastrow.clone()
		$newrow.find('.admin-username').text(username)
		$newrow.click(removeBtnClickHandler)
		$newrow.insertAfter($lastrow)
		updateRemoveBtns()
	)

	# Submit changes
	$('.save-changes-btn').click( ->
		usernames = $.map($('.admin-username'), (v) -> $(v).text().trim())
		$.post('/admin/settings/update_admins', { 'usernames': usernames })
	)

moderation = ->
	return if not $('body').hasClass('moderation')

	$dismiss_btn = $('.dismiss-btn');
	$dismiss_btn.click( ->
		# Prepare AJAX call
		obj_id = $dismiss_btn.data('obj-id')
		obj_type = $dismiss_btn.data('obj-type')
		req_data = { 'type': 'POST', 'data': { 'obj-id': obj_id, 'obj-type': obj_type } }

		# Make AJAX call
		$.ajax('/report/dismiss', req_data).success( ->
			# Hide row
			$dismiss_btn.closest('tr').fadeOut()
		)
	)

ready = ->
	return if not $('body').hasClass('admin')

	settings()
	moderation()


$(document).ready(ready)
$(document).on('page:load', ready)
