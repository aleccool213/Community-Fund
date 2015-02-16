require "rails_helper"

RSpec.describe User, :type => :model do
	it "is not an admin by default" do
		user = User.create(username: 'TestUser', email: 'test@test.ca',
						   password: 'test', password_confirmation: 'test')

		expect(user.admin).to be false
	end
end
