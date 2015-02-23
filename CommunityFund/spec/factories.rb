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

	factory :community do
		sequence(:name)			{ |n| Faker::Commerce.department }
		sequence(:description)	{ |n| Faker::Lorem.paragraph }
		active					true
	end

	factory :reward do
		reward_level      100
		sequence(:description)	{ |n| Faker::Company.catch_phrase}
	end

	factory :project do
		sequence(:name)			{ |n| Faker::Commerce.product_name }
		sequence(:description)	{ |n| Faker::Lorem.paragraph }
		target_amount				1600
		completion_date			DateTime.now + 1.month
		communities					[ FactoryGirl.create(:community) ]
		initiator_id				FactoryGirl.create(:user).id
		open                true

		trait :with_rewards do
			rewards							[ FactoryGirl.create(:reward), FactoryGirl.create(:reward)]
		end
	
	end

	factory :fund do
		user  							FactoryGirl.create(:user)
  	project							FactoryGirl.create(:project, :with_rewards)					
    amount            	100
  end

  factory :feedback do
    rating						0
    submitted   			false
    dismissed					false
    description 			"Project was great"
    user_id 					FactoryGirl.create(:user).id
    project_id     		FactoryGirl.create(:project).id  
  end

end
