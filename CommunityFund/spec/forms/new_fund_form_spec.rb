require 'rails_helper'

RSpec.describe 'new fund form' do
  before(:each) do
    @communities = [FactoryGirl.create(:community)]
    @project = FactoryGirl.create(:project, :with_rewards, communities: @communities)
    @user = FactoryGirl.create(:user)
    @fund_params = {
      new_fund_form: {
        amount: 100,
      },
      reward_id: ""
    }
    @fund_params["community_#{@communities.first.id}"] = "true"
  end

  it "should create the new fund and add the user to the communities" do
    @new_fund_form = NewFundForm.new(user: @user, project: @project, communities: @communities)
    @new_fund_form.submit(@fund_params)
    fund = @new_fund_form.fund
    expect(fund.reward_id).to eq(nil)
    expect(fund.amount).to eq(@fund_params[:new_fund_form][:amount])
    expect(@user.reload.communities).to eq(@communities)
  end

  it "should add the reward to the fund" do
    @new_fund_form = NewFundForm.new(user: @user, project: @project, communities: @communities)
    @fund_params[:reward_id] = @project.rewards.first.id
    @new_fund_form.submit(@fund_params)
    fund = @new_fund_form.fund
    expect(fund.reward_id). to eq(@project.rewards.first.id)
  end
end
