Then(/^I go to my profile page$/) do
  visit("/users/#{@user.username}")
end

Then(/^I should see my profile details$/) do
  page.has_content?(@user.username)
  page.has_content? @user.created_at
  page.has_content? @user.email
  page.has_content? @user.communities
  page.has_content? @user.hometown
  page.has_content? @user.homestate
  page.has_content? @user.projects
  page.has_content? @user.funds
  page.has_content? @user.feedbacks
end