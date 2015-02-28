require 'rails_helper'

RSpec.describe LocationController, :type => :controller do
	describe 'POST #countries' do
		before do
			Location.create!(country_code: 'MN')
			Location.create!(country_code: 'AB')
			Location.create!(country_code: 'XY')
		end

		it 'should return a sorted list of countries' do
			xhr :get, :countries

			expect(response).to be_success
			json_response = JSON.parse(response.body)
			expect(json_response).to eq ['AB','MN','XY']
		end
	end

	describe 'POST #cities' do
		before do
			Location.create!(country_code: 'MN', asciiname: 'Q')
			Location.create!(country_code: 'AB', asciiname: 'Q')
			Location.create!(country_code: 'XY', asciiname: 'S')
			Location.create!(country_code: 'AB', asciiname: 'P')
		end

		it 'should not succeed if missing country' do
			xhr :get, :cities

			expect(response).not_to be_success
			expect(response).to have_http_status 400
		end

		it 'should not succeed if given country is invalid' do
			xhr :post, :cities, { country: 'ZZ' }

			expect(response).not_to be_success
			expect(response).to have_http_status 404
		end

		it 'should return sorted cities if country provided' do
			# Act
			xhr :get, :cities, { country: 'AB' }

			# Assert
			expect(response).to be_success
			json_response = JSON.parse(response.body)
			expect(json_response).to eq ['P','Q']
		end
	end
end
