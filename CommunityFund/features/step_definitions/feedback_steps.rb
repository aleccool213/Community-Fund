Then(/^the project should have created feedback$/) do
  @feedback = Feedback.last
  expect(@feedback.project).to eq(Project.last)
  expect(@feedback.user).to eq(User.last)
  expect(@feedback.rating).to eq(0)
  expect(@feedback.submitted?).to eq(false)
  expect(@feedback.dismissed?).to eq(false)
end

Then(/^the user has pending feedback$/) do
  @feedback = FactoryGirl.create(:feedback, user: User.last, project: FactoryGirl.create(:project))
end

Then(/^I should see the pending feedback$/) do
  page.has_content? "#{@feedback.project.name} has completed the funding process! Please fill out form upon completion or delivery."
end

Then(/^I dismiss the feedback$/) do
  click_button("dismiss_button_#{@feedback.id}")
  sleep 1
end

Then(/^the feedback should be dismissed$/) do
  step %{I should not see "#{@feedback.project.name} has completed the funding process! Please fill out form upon completion or delivery."}
  expect(@feedback.dismissed?).to eq(true)
end
