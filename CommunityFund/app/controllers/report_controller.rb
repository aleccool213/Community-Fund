class ReportController < ApplicationController
	before_action :authenticate_user!
	respond_to :json

	def project
		if not params.has_key? :project_id
			render json: { errors: 'Request missing project_id' }, status: 400
			return
		end

		project_id = params[:project_id]
		project = Project.find_by_id(project_id)
		if (project == nil)
			render json: { errors: 'Project not found' }, status: 404
			return
		end

		old_report = Report.where(["user_id = ? and reported_obj_id = ?", current_user.id, project_id])
		if (not old_report.empty?)
			render json: { errors: 'Report previously submitted' }, status: 400
			return
		end

		@report = Report.create(
			user: current_user,
			reported_obj_type: :project,
			reported_obj_id: project.id)
		respond_with @report, location: nil
	end
end
