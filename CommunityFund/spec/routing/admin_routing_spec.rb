require 'rails_helper'

RSpec.describe 'routing to profiles', :type => :routing do
	it 'routes /admin/analytics to admin#analytics' do
		expect(:get => '/admin/analytics').to route_to controller: 'admin', action: 'analytics'
	end

	it 'routes /admin/settings to admin#settings' do
		expect(:get => '/admin/settings').to route_to controller: 'admin', action: 'settings'
	end
end
