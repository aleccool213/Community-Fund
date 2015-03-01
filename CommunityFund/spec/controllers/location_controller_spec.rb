require 'rails_helper'

RSpec.describe LocationController, :type => :controller do
	describe 'POST #countries' do
		it 'should return a sorted list of countries' do
			xhr :get, :countries

			expect(response).to be_success
			json_response = JSON.parse(response.body)
			expect(json_response).not_to be_blank
			sorted = json_response.sort_by { |o| o['country'] }
			expect(json_response).to eq sorted
		end
	end

	describe 'POST #cities' do
		it 'should not succeed if missing country' do
			xhr :get, :cities

			expect(response).not_to be_success
			expect(response).to have_http_status 400
		end

		it 'should not succeed if given id is invalid' do
			xhr :post, :cities, { country_id: 'XYZ' }

			expect(response).not_to be_success
			expect(response).to have_http_status 404
		end

		it 'should not succeed if given id is a city' do
			xhr :post, :cities, { country_id: 5368361 }

			expect(response).not_to be_success
			expect(response).to have_http_status 404
		end

		it 'should return sorted cities if country provided' do
			# Act
			xhr :get, :cities, { country_id: 6251999 }

			# Assert
			expect(response).to be_success
			json_response = JSON.parse(response.body)
			expect(json_response).not_to be_blank
			sorted = json_response.sort { |x,y| x['name'] <=> y['name'] }
			expect(json_response).to eq sorted
		end
	end
end
