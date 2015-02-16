require 'rails_helper'

RSpec.describe 'routing to profiles', :type => :routing do
	it 'routes /admin/analytics to admin#analytics' do
		expect(:get => '/admin/analytics').to route_to controller: 'admin', action: 'analytics'
	end
end
