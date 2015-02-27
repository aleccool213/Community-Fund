class ReportController < ApplicationController
	before_action :authenticate_user!, except: [:dismiss]
	before_action :authenticate_admin!, only: [:dismiss]

	respond_to :json

	def dismiss
		# Check if request format is valid
		if (not params.has_key? "obj-type") or (not params.has_key? "obj-id")
			render json: { errors: 'Invalid request' }, status: 400
			return
		end

		# Check if such reports exist
		obj_type = params["obj-type"]
		obj_id = params["obj-id"]
		reports = Report.where(['reported_obj_type = ? and reported_obj_id = ?', obj_type, obj_id])
		if reports.empty?
			render json: { errors: 'No such reports found' }, status: 404
			return
		end

		# Destroy the reports
		reports.each { |r| r.delete }
		render json: reports.to_json
	end

	def project
		# Check if request format is valid
		if not params.has_key? :project_id
			render json: { errors: 'Request missing project_id' }, status: 400
			return
		end

		# Check if project exists
		project_id = params[:project_id]
		project = Project.find_by_id(project_id)
		if (project == nil)
			render json: { errors: 'Project not found' }, status: 404
			return
		end

		# Check for duplicate reports
		old_report = Report.where(["user_id = ? and reported_obj_id = ?", current_user.id, project_id])
		if (not old_report.empty?)
			render json: { errors: 'Report previously submitted' }, status: 400
			return
		end

		# Create report
		@report = Report.create(user: current_user, reported_obj_type: :project, reported_obj_id: project.id)
		render json: @report.to_json
	end
end
