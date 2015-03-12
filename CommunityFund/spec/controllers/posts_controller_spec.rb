require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @project = FactoryGirl.create(:project)
    @community = FactoryGirl.create(:community)
    @content = Faker::Company.catch_phrase
    
  end

  it "should not append a comment if no user is signed in" do
    expect {
      xhr :post, :create, object_type: "project", object_id: @project.id, content: @content
    }.to change(Post, :count).by(0)

    expect(response).not_to be_success
    expect(response).to have_http_status 401
  end

  it "should append the post to a specified project" do
    sign_in @user
    expect {
      xhr :post, :create, object_type: "project", object_id: @project.id, content: @content
    }.to change(Post, :count).by(1)

    expect(response).to be_success
    @post = Post.last
    expect(@post.project_id).to eq(@project.id)
    expect(@post.community_id).to eq(nil)
    expect(@post.user_id).to eq(@user.id)
    expect(@post.content).to eq(@content)
  end

  it "should append the post to a specified community" do
    sign_in @user
    expect {
      xhr :post, :create, object_type: "community", object_id: @community.id, content: @content
    }.to change(Post, :count).by(1)

    expect(response).to be_success
    @post = Post.last
    expect(@post.project_id).to eq(nil)
    expect(@post.community_id).to eq(@community.id)
    expect(@post.user_id).to eq(@user.id)
    expect(@post.content).to eq(@content)
  end

  it "should return error if the content is empty" do
    sign_in @user

    expect {
      xhr :post, :create, object_type: "community", object_id: @community.id, content: ""
    }.to change(Post, :count).by(0)

    expect(response).to be_success
    expect(JSON.parse(response.body)["status"]).to eq("failure")
  end
end
