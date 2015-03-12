class EditFundForm < Form
  attr_accessor :amount, :project, :fund

  def initialize(options = {})
    super(options)
    self.project = options[:project]
    self.fund = options[:fund]
    self.amount = fund.amount
  end

  def submit(attrs)
    self.fund.amount = attrs[:edit_fund_form][:amount]
    if attrs[:reward_id].present?
      self.fund.reward_id = Reward.find(attrs[:reward_id]).try(:id)
    else
      self.fund.reward_id = nil
    end

    self.fund.save
  end
end