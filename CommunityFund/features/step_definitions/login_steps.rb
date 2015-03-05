Given(/^a community exists$/) do
  @community = FactoryGirl.create(:community)
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
  @community = Community.active.first
  check("collect_information_form[community_#{@community.id}]")
  click_button("submit_button")
end

Then(/^I should belong to the selected community$/) do
  expect(@user.communities.count).to eq(1)
  expect(@user.communities.first.name). to eq(Community.first.name)
end

# this doesn't like labels that aren't attached to input fields so specify the element id
Then(/^I fill in my login details$/) do
  fill_in 'login-username-input', with: @user.username
  fill_in 'login-password-input', with: @user.password
  click_button('login_button')
end

Then(/^I fill in my signup details$/) do
  @user = FactoryGirl.build(:user)
  fill_in 'signup-username-input', with: @user.username
  fill_in 'signup-password-input', with: @user.password
  fill_in 'signup-password-confirm-input', with: @user.password
  fill_in 'signup-email-input', with: @user.email
  click_button('signup_button')
end

Then(/^show me the page$/) do
  save_and_open_page
end
