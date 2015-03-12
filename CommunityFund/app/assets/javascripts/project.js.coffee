ready = ->
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

$(document).ready(ready)
$(document).on('page:load', ready)
