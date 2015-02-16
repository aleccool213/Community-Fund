ready = ->
	return if not $('body').hasClass('admin')

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

$(document).ready(ready)
$(document).on('page:load', ready)
