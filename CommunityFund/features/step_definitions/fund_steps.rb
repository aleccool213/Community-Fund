Then(/^I create a donation$/) do
  page.has_content? "Donation to #{@project.name}"
  fill_in 'new_fund_form_amount', with: "0"
  page.has_content? "Please enter an amount greater than $5"
  fill_in 'new_fund_form_amount', with: "#{@project.rewards.first.reward_level}"
  # TODO use javascript to select reward
  click_button("submit_button")
end

Then(/^I edit my donation$/) do
  @fund = Fund.last
  page.has_content? "Edit donation for #{@fund.project.name}"
  fill_in 'edit_fund_form_amount', with: @fund.project.rewards.last.reward_level
  # TODO use javascript to select other reward
  click_button("submit_button")
end

Then(/^I should see my donation$/) do
  page.has_content? "You have donated"
  page.has_content? "$#{Fund.last.amount}.00"
end

Then(/^I should see my donation has changed$/) do
  step "I should see my donation"
end