require 'rails_helper'

RSpec.describe ReportController, :type => :controller do
	shared_examples_for 'a page requiring login' do |path|
		context 'when not logged in' do
			it 'should not succeed' do
				@project = create(:project)
				xhr :post, path, { 'project_id': @project.id }

				expect(response).not_to be_success
			end
		end

		context 'when logged in' do
			before do
				@user = create(:user)
				@project = create(:project)
				sign_in @user
			end

			it 'should succeed' do
				xhr :post, path, { 'project_id': @project.id }

				expect(response).to be_success
			end

			it 'should not succeed if missing project_id' do
				xhr :post, path, { }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end

			it 'should not succeed if project is invalid' do
				xhr :post, path, { 'project_id': @project.id + 1 }

				expect(response).not_to be_success
				expect(response).to have_http_status 404
			end

			it 'should not succeed if report already exists' do
				xhr :post, path, { 'project_id': @project.id }
				xhr :post, path, { 'project_id': @project.id }

				expect(response).not_to be_success
				expect(response).to have_http_status 400
			end
		end
	end

	describe 'POST #project' do
		it_should_behave_like 'a page requiring login', :project
	end
end
