require 'rails_helper'

RSpec.describe 'new project form' do
  before(:each) do
    @communities = [FactoryGirl.create(:community)]
    @user = FactoryGirl.create(:user)
    @project_params = {
      project: {
        name: "New project",
        description: "New project decription",
        "completion_date(1i)" => "2017",
        "completion_date(2i)" => "1",
        "completion_date(3i)" => "1",
        target_amount: 6000,
        rewards_attributes: {
          "0"=> {
            reward_level: "100", description: "A smooch", "_destroy"=>"false"},
          "1"=> {
            reward_level: "150", description: "A double smooch", "_destroy"=>"false"}
        }
      }
    }
    @project_params["community_#{@communities.first.id}".to_sym] = "1"
  end

  it "should create a new project given all parameters" do
    @new_project_form = NewProjectForm.new(user: @user, communities: @communities)
    @new_project_form.submit(@project_params)
    project = @new_project_form.project
    expect(project.initiator.id).to eq(@user.id)
    expect(project.name).to eq(@project_params[:project][:name])
    expect(project.open).to eq(true)
    expect(project.communities).to eq(@communities)
    expect(project.rewards.count).to eq(2)
  end

  it "should create a project if no rewards are specified" do
    @project_params[:project][:rewards_attributes] = nil
    @new_project_form = NewProjectForm.new(user: @user, communities: @communities)
    @new_project_form.submit(@project_params)
    project = @new_project_form.project
    expect(project.rewards.count).to eq(0)
  end
end