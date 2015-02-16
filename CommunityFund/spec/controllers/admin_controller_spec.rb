require 'rails_helper'

RSpec.describe AdminController, :type => :controller do
	describe 'GET #analytics' do
		context 'when not logged in' do
			before do
				get :analytics
			end

			it 'should redirect to the sign-in page' do
				expect(response).to redirect_to new_user_session_path
			end
		end

		context 'when logged in as a non-admin' do
			before do
				user = create(:user)
				sign_in user
				get :analytics
			end

			it 'should redirect to the dashboard' do
				expect(response).to redirect_to dashboard_path
			end
		end

		context 'when logged in as an admin' do
			before do
				admin = create(:admin)
				sign_in admin
			end

			it "should load the analytics page" do
				expect(response).to be_success
				expect(response).to have_http_status 200
				expect(response).to render_template "analytics"
			end
		end
	end
end
