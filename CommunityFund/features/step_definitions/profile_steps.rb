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
    end
  else
    page.should have_text "hasn't funded any projects."
  end
  
  if @user.hometown
    page.should have_text "Hometown: #{@user.hometown}"
  else
    page.should have_text "Hometown: Not specified"
  end
  
  if @user.homestate
    page.should have_text "Homestate: #{@user.homestate}"
  else
    page.should have_text "Homestate: Not specified"
  end
  
  if @user.feedbacks.any?
    for feedback in @user.feedbacks
      page.should have_text feedback.user.username
      page.should have_text feedback.description
    end
  else
    page.should have_text "hasn't received any feedback."
  end
end