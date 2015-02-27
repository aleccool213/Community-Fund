require 'rails_helper'

RSpec.describe 'report routing', :type => :routing do
	it 'routes /report/dismiss to report#dismiss' do
		expect(:post => '/report/dismiss').to route_to controller: 'report', action: 'dismiss'
	end

	it 'routes /report/project to report#project' do
		expect(:post => '/report/project').to route_to controller: 'report', action: 'project'
	end
end
