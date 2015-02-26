Given(/^I go to the Home Page$/) do
	visit root_path
end

Given(/^I am signed in as an? (.*)$/) do |user_type|
	@user = FactoryGirl.create(user_type)
	visit new_user_session_path
	fill_in 'user_username', with: @user.username
	fill_in 'user_password', with: @user.password
	click_button 'login_button'
end

Then(/^I should see my username$/) do
	expect(page).to have_content @user.username
end
