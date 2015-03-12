Given(/^a community exists$/) do
  @community = FactoryGirl.create(:community)
end

Then(/^the community has posted comments$/) do
  @post = Post.create(user_id: FactoryGirl.create(:user).id, community_id: @community.id, content: "Some arbitrary comment")
end