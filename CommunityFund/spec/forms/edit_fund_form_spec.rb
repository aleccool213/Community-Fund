require 'rails_helper'

RSpec.describe 'edit fund form' do
  before(:each) do
    @communities = [FactoryGirl.create(:community)]
    @project = FactoryGirl.create(:project, :with_rewards)
    @fund = FactoryGirl.create(:fund, project: @project)
    @fund_params = {
      edit_fund_form: {
        amount: 1000,
      },
      reward_id: @project.rewards.last.id
    }
  end

  it "edit the fund amount and change the reward" do
    @edit_fund_form = EditFundForm.new(fund: @fund, user: @fund.user, project: @fund.project)
    @edit_fund_form.submit(@fund_params)
    fund = @edit_fund_form.fund
    expect(fund.reward_id).to eq(@project.rewards.last.id)
    expect(fund.amount).to eq(1000)
  end
end