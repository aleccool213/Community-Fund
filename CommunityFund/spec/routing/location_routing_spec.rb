require 'rails_helper'

RSpec.describe 'location routing', :type => :routing do
	it 'routes /location/countries to location#countries' do
		expect(:get => '/location/countries').to route_to controller: 'location', action: 'countries'
	end

	it 'routes /location/cities to location#cities' do
		expect(:get => '/location/cities').to route_to controller: 'location', action: 'cities'
	end
end
