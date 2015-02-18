require 'rails_helper'

RSpec.describe 'edit project form' do
  before(:each) do
    @project = FactoryGirl.create(:project)
    @communities = @project.communities
    @user = User.find(@project.initiator_id)
    @project_params = {
      project: {
        name: "New project",
        description: "New project decription",
        "completion_date(1i)" => "2017",
        "completion_date(2i)" => "1",
        "completion_date(3i)" => "1",
        target_amount: 6000,
        "rewards_attributes" => {
          "0"=> {
            "reward_level"=>"100", "description"=>"A smooch", "_destroy"=>"false"},
          "1"=> {
            "reward_level"=>"150", "description"=>"A double smooch", "_destroy"=>"false"}
        }
      }
    }
  end

  it "should edit the project information" do
    @edit_project_form = EditProjectForm.new(user: @user, communities: @communities, project: @project)
    @edit_project_form.submit(@project_params)
    project = @edit_project_form.project
    expect(project.rewards.count).to eq(2)
    # TODO fix project rewards
  end
end