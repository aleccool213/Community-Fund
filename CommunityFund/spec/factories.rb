FactoryGirl.define do
	factory :user do
		sequence(:username)		{ |n| Faker::Internet.user_name }
		sequence(:email)		{ |n| Faker::Internet.email }
		password				"password1-"
		password_confirmation	"password1-"

		factory :admin do
			admin true
		end
	end
end
