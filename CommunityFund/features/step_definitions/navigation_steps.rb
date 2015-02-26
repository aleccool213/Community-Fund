Then(/^I should see my username$/) do
	expect(page).to have_content @user.username
end
