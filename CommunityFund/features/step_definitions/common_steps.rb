Then(/^I go to the "(.*?)"$/) do |arg1|
  visit(visit_url[arg1])
end

When(/^I login$/) do 
  visit(new_user_session_path)
end

Then(/^I am on the "(.*?)"$/) do |arg1|
  visit(visit_url[arg1])
end

def visit_url
  @project ||= FactoryGirl::create(:project)
  @community ||= FactoryGirl::create(:community)
  {
    "Home Page" => root_path,
    "Login Page" => new_user_session_path,
    "Signup Page" => new_user_registration_path,
    "Create Project Page" => new_project_path,
    "newest project" => project_path(@project),
    "Community Page" => community_path(@community)
  }
end

Then(/^I click on the "(.*?)" button$/) do |arg1|
  click_button(arg1)
end

Then(/^I click on the "(.*?)" link$/) do |arg1|
  click_link(arg1)
end

Then(/^I should see "(.*?)"$/) do |text|
	expect(page).to have_content text
end

Then(/^I should not see "(.*?)"$/) do |text|
    expect(page).not_to have_content text
end

Then(/^I should see a (?:field|button) with ([a-zA-Z]+) "(.*)"$/) do |prop, name|
	expect(page).to have_selector("input[contains(@" + prop + ", '" + name + "')]")
end

Then(/^I should not see a (?:field|button) with ([a-zA-Z]+) "(.*)"$/) do |prop, name|
	expect(page).not_to have_selector("input[contains(@" + prop + ", '" + name + "')]")
end

Given(/^I am signed in as an? (.*)$/) do |user_type|
	@user = FactoryGirl.create(user_type)
	visit new_user_session_path
    fill_in 'login-username-input', with: @user.username
    fill_in 'login-password-input', with: @user.password
	click_button 'login_button'
end

