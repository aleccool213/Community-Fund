ready = ->
	return if not $('body').hasClass('communities')

	$join_btn = $('.join-btn');
	$join_modal_btn = $('.join-confirm-btn');

	$join_modal_btn.click( ->
		# Prepare AJAX call
		community_id = $join_btn.data('community-id')
		req_data = { 
			'type': 'POST',
			'data': { 'community_id': community_id } 
		}

		# Make AJAX call
		$.ajax('/communities/' + community_id + '/join', req_data).success( ->
			# Hide 'Join Community' button
			$join_btn.fadeOut()
		)
	)

$(document).ready(ready)
$(document).on('page:load', ready)