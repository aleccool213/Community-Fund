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

	factory :project do
		sequence(:name)			{ |n| Faker::Commerce.product_name }
		sequence(:description)	{ |n| Faker::Lorem.paragraph }
	end

	factory :community do
		sequence(:name)			{ |n| Faker::Commerce.department }
		sequence(:description)	{ |n| Faker::Lorem.paragraph }
		active					true
	end
end
