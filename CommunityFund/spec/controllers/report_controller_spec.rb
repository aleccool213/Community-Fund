require 'rails_helper'

RSpec.describe ReportController, :type => :controller do
	describe 'POST #dismiss' do
		context 'when not logged in' do
			before do
				@user = create(:user)
				@project = create(:project)
			end

			it 'should not be authorized' do
				@report = Report.create(user: @user, reported_obj_id: @project.id, reported_obj_type: 'project')
				xhr :post, :dismiss, { 'obj-type': 'project', 'obj-id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 401
			end
		end

		context 'when logged in as a user' do
			before do
				@user = create(:user)
				@project = create(:project)
				sign_in @user
			end

			it 'should not be authorized' do
				@report = Report.create(user: @user, reported_obj_id: @project.id, reported_obj_type: 'project')
				xhr :post, :dismiss, { 'obj-type': 'project', 'obj-id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 401
			end
		end

		context 'when logged in as an admin' do
			before do
				@user = create(:admin)
				@project = create(:project)
				sign_in @user
			end

			it 'should succeed if reports exist' do
				# Arrange
				@report = Report.create(user: @user, reported_obj_id: @project.id, reported_obj_type: 'project')
				report_other_proj = Report.create(user: @user, reported_obj_id: @project.id + 1, reported_obj_type: 'project')
				report_other_user = Report.create(user: create(:user), reported_obj_id: @project.id, reported_obj_type: 'project')
				report_other_both = Report.create(user: create(:user), reported_obj_id: @project.id + 1, reported_obj_type: 'project')
				expect(Report.count).to eq 4

				# Act
				xhr :post, :dismiss, { 'obj-type': 'project', 'obj-id': @project.id }

				# Assert
				expect(response).to be_success
				expect(Report.count).to eq 2
				reports = Report.where(['reported_obj_type = "project" and reported_obj_id = ?', @project.id])
				expect(reports).to be_empty
			end

			it 'should not succeed if missing obj-type' do
				@report = Report.create(user: @user, reported_obj_id: @project.id, reported_obj_type: 'project')
				xhr :post, :dismiss, { 'obj-id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end

			it 'should not succeed if missing obj-id' do
				@report = Report.create(user: @user, reported_obj_id: @project.id, reported_obj_type: 'project')
				xhr :post, :dismiss, { 'obj-type': 'project' }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end

			it 'should not succeed if no such reports exist' do
				xhr :post, :dismiss, { 'obj-type': 'project', 'obj-id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 404
			end
		end
	end

	describe 'POST #project' do
		context 'when not logged in' do
			before do
				@project = create(:project)
			end

			it 'should not be authorized' do
				xhr :post, :project, { 'project_id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 401
			end
		end

		context 'when logged in' do
			before do
				@user = create(:admin)
				@project = create(:project)
				sign_in @user
			end

			it 'should succeed' do
				xhr :post, :project, { 'project_id': @project.id }

				expect(response).to be_success
			end

			it 'should not succeed if missing project_id' do
				xhr :post, :project, { }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end

			it 'should not succeed if project is invalid' do
				xhr :post, :project, { 'project_id': @project.id + 1 }

				expect(response).not_to be_success
				expect(response).to have_http_status 404
			end

			it 'should not succeed if report already exists' do
				xhr :post, :project, { 'project_id': @project.id }
				xhr :post, :project, { 'project_id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end
		end
	end
end
