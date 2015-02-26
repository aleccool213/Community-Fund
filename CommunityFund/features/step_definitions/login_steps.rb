Given(/^a community exists$/) do
  FactoryGirl.create(:community)
end

Given(/^I am on the Home Page$/) do
  visit(root_url)
end

When(/^I go to the Login page$/) do
  visit("/users/sign_in")
end

When(/^I go to the Signup Page$/) do
  visit("/users/sign_up")
end

Given(/^I have created a user account$/) do
  @user = FactoryGirl.create(:user)
end

Then(/^the new user should be created$/) do
  latest_user = User.last
  expect(latest_user.username).to eq(@user.username)
  @user = latest_user
end

Then(/^I click on the first community$/) do
  @community = Community.first
  check('collect_information_form[community_1]')
  click_button("submit_button")
end

Then(/^I should belong to the selected community$/) do
  @user = User.last
  expect(@user.communities.count).to eq(1)
  expect(@user.communities.first.name). to eq(Community.first.name)
end

# this doesn't like labels that aren't attached to input fields so specify the element id
Then(/^I fill in my login details$/) do
  fill_in 'user_username', with: @user.username
  fill_in 'user_password', with: @user.password
  click_button('login_button')
end

Then(/^I fill in my signup details$/) do
  @user = FactoryGirl.build(:user)
  fill_in 'user_username', with: @user.username
  fill_in 'user_password', with: @user.password
  fill_in 'user_password_confirmation', with: @user.password
  fill_in 'user_email', with: @user.email
  click_button('signup_button')
end
