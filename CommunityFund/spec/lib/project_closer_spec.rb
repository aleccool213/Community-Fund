require 'rails_helper'
require 'project_closer'

RSpec.describe "Project Closer" do
  before(:each) do
    @project1 = FactoryGirl.create(:project)
    @project2 = FactoryGirl.create(:project, completion_date: DateTime.now - 1.day, target_amount: 1000)
    @project3 = FactoryGirl.create(:project, target_amount: 1000)
    @project4 = FactoryGirl.create(:project, open: false)
  end

  it "should close projects whose deadlines have passed" do
    ProjectCloser.close
    expect(@project1.reload.open?).to eq(true)
    expect(@project2.reload.open?).to eq(false)
    expect(@project3.reload.open?).to eq(true)
    expect(@project4.reload.open?).to eq(false)
  end

  it "should set the funding successful flag when enough funds have been given to a project" do
    @project3.update(completion_date: DateTime.now - 1.day)
    # add insufficient funds for @project2
    FactoryGirl.create(:fund, project: @project2, amount: 40)
    FactoryGirl.create(:fund, project: @project2, amount: 40)

    # add sufficient funds for @project3
    FactoryGirl.create(:fund, project: @project3, amount: 600)
    FactoryGirl.create(:fund, project: @project3, amount: 600)

    ProjectCloser.close
    expect(@project2.reload.open?).to eq(false)
    expect(@project2.funding_successful?).to eq(false)

    expect(@project3.reload.open?).to eq(false)
    expect(@project3.funding_successful?).to eq(true)
  end

  it "should create notices for users to gather feedback when a project closes" do

  end
end