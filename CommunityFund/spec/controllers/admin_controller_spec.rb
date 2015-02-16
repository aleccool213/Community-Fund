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

			it 'should load the analytics page' do
				get :analytics

				expect(response).to be_success
				expect(response).to have_http_status 200
				expect(response).to render_template 'analytics'
			end

			it 'loads user sign-up data' do
				# Insert test data
				users = build_list(:user, 3)
				users[0].created_at = Time.new(2015, 01, 18, 12, 0, 0)
				users[1].created_at = Time.new(2015, 02, 03, 10, 0, 0)
				users[2].created_at = Time.new(2015, 02, 03, 14, 0, 0)
				users.each { |u| u.save! }
				today_key = Date.today.strftime('%Y-%m-%d 00:00:00 UTC')

				# Create expected data
				signup_data = {
					'2015-01-18 00:00:00 UTC' => 1,
					'2015-02-03 00:00:00 UTC' => 2,
					Date.today.strftime('%Y-%m-%d 00:00:00 UTC') => 1
				}
				earliest_date = Date.new(2015, 1, 18)
				data_size = (Date.today - earliest_date + 1)

				# Navigate to page
				get :analytics

				# Test signup data
				actual = assigns(:signups_by_day)
				expect(actual.length).to eq data_size
				cur_date = earliest_date
				while cur_date <= Date.today do
					key = cur_date.strftime('%Y-%m-%d 00:00:00 UTC')

					expect(actual).to have_key key
					if signup_data.has_key? key
						expect(actual[key]).to eq signup_data[key]
					else
						expect(actual[key]).to eq 0
					end

					cur_date += 1.day
				end
			end

			it 'loads project creation data' do
				# Insert test data
				projects = build_list(:project, 3)
				projects[0].created_at = Time.new(2015, 01, 18, 12, 0, 0)
				projects[1].created_at = Time.new(2015, 02, 03, 10, 0, 0)
				projects[2].created_at = Time.new(2015, 02, 03, 14, 0, 0)
				projects.each { |p| p.save! }

				# Create expected data
				creation_data = {
					'2015-01-18 00:00:00 UTC' => 1,
					'2015-02-03 00:00:00 UTC' => 2,
				}
				earliest_date = Date.new(2015, 1, 18)
				data_size = (Date.today - earliest_date + 1)

				# Navigate to page
				get :analytics

				# Test signup data
				actual = assigns(:projects_by_day)
				expect(actual.length).to eq data_size
				cur_date = earliest_date
				while cur_date <= Date.today do
					key = cur_date.strftime('%Y-%m-%d 00:00:00 UTC')

					expect(actual).to have_key key
					if creation_data.has_key? key
						expect(actual[key]).to eq creation_data[key]
					else
						expect(actual[key]).to eq 0
					end

					cur_date += 1.day
				end
			end

			it 'loads user geographic data' do
				# Insert test data
				users = build_list(:user, 3)
				users[0].last_sign_in_ip = '208.113.47.243'
				users[1].last_sign_in_ip = '64.29.11.20'
				users[2].last_sign_in_ip = '65.28.12.56'
				users.each { |u| u.save! }

				# Navigate to page
				get :analytics

				# Test geo data
				actual = assigns(:geo_data)
				expect(actual).to eq('United States' => 2, 'Canada' => 1)
			end
		end
	end
end
