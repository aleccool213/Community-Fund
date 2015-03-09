require 'rails_helper'

RSpec.describe 'edit project form' do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @communities = @project.communities
    @user = User.find(@project.initiator.id)
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
  end

  it "should edit the project information" do
    @edit_project_form = EditProjectForm.new(user: @user, communities: @communities, project: @project)
    @edit_project_form.submit(@project_params)
    project = @edit_project_form.project
    expect(project.rewards.count).to eq(2)
  end

  it "should edit and remove rewards that already exist for the project" do
    @project = FactoryGirl.create(:project, :with_rewards)
    @edit_project_form = EditProjectForm.new(user: @user, communities: @communities, project: @project)
    expect(@project.rewards.count).to eq(2)
    @project_params[:project][:rewards_attributes] = {
      "0" => {reward_level: "100", description: "A smooch", "_destroy" => "1", "id" => @project.rewards.first.id},
      "1" => {reward_level: "1200", description: "A hot smooch", "_destroy" => "false", "id" => @project.rewards.last.id}
    }
    @edit_project_form.submit(@project_params)
    @project = @edit_project_form.project
    @project.reload # new reward updates aren't showing up without this
    expect(@project.rewards.count).to eq(1)
    @reward = @project.rewards.last
    expect(@reward.reward_level).to eq(1200)
    expect(@reward.description).to eq("A hot smooch")
  end
end