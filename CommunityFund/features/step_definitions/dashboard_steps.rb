
Given(/^I am apart of communities$/) do
	@community = FactoryGirl.create(:community)
	@user.communities << @community
end

Given(/^I have started projects$/) do
  @project = FactoryGirl.create(:project, :with_rewards, communities: [@user.communities.first])
  @user.projects << @project
end

Given(/^I have funded projects$/) do
  fund = Fund.create(:user_id => @user.id, :project_id => @project.id, :amount => 100)
end

Given(/^those communities have projects$/) do 
  @project = FactoryGirl.create(:project, :with_rewards, communities: [@user.communities[0]])
  @user.communities[0].projects << FactoryGirl.create(:project, :with_rewards, communities: [@user.communities[0]])
end

Then(/^should appear latest milestone$/) do
  #grab latest milestones from projects within current_users communities
  milestone = @project.milestones.first
  expect(page).to have_content milestone.description
end

Then(/^should appear latest feedback$/) do
  expect(page).to have_content (@user.username + " has submitted feedback on #{@user.feedbacks.first.project.name}")
end