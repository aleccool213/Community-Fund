Then(/^I fill in my project details$/) do
  fill_in 'project_name', with: "New Project"
  fill_in 'project_description', with: "A brand new community project"
  fill_in 'project_target_amount', with: "1000"
  check "community_#{Community.active.first.id}"
end

Then(/^I click on the "(.*?)" button$/) do |arg1|
  click_button(arg1)
end