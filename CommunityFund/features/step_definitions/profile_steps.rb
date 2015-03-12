Then(/^I go to my profile page$/) do
  visit("/users/#{@user.username}")
end

Then(/^I go to the profile page of "(.*?)"$/) do |arg1|
  visit("/users/#{arg1}")
end

Then(/^I should see my profile details$/) do
  page.should have_text @user.username
  if @user.admin
    page.should have_text "admin"
  else
    page.should have_text "member"
  end
  page.should have_text @user.created_at.to_date
  page.should have_text @user.email

  if @user.communities.any?
    for community in @user.communities
      page.should have_text community.name
    end
  else
    page.should have_text "None"
  end

  if @user.projects.any?
    for project in @user.projects
      page.should have_text project.name
      page.should have_text project.description
    end
  else
    page.should have_text "hasn't started any projects."
  end

  if @user.funds.any?
    for fund in @user.funds
      page.should have_text fund.project.name
      page.should have_text fund.amount
      page.should have_text fund.reward.present? ? "Reward: #{fund.reward.description}" : ""
    end
  else
    page.should have_text "hasn't funded any projects."
  end

  page.should have_text "City: #{@user.geo_community.present? ? @user.geo_community.city : 'Not Specified'}"
  page.should have_text "Country: #{@user.geo_community.present? ? @user.geo_community.city : 'Not Specified'}"

  page.should have_text @user.projects.count
  page.should have_text @user.projects.where(:funding_successful => true).count
  page.should have_text @user.funds.count
  page.should have_text @user.funds.sum(:amount)
  page.should have_text @funds.present? ? @funds.average(:amount) : '0.0'

  if @user.feedbacks.any?
    for feedback in @user.feedbacks
      page.should have_text feedback.user.username
      page.should have_text feedback.description
    end
  else
    page.should have_text "hasn't received any feedback."
  end
end
