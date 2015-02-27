require 'rails_helper'

RSpec.describe 'report routing', :type => :routing do
	it 'routes /report/project to report#project' do
		expect(:post => '/report/project').to route_to controller: 'report', action: 'project'
	end
end
