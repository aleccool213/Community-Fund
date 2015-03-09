class NewFundForm < Form
  attr_accessor :amount, :project, :fund, :communities

  def initialize(options = {})
    super(options)
    self.communities = options[:communities]
    self.project = options[:project]
    self.fund = Fund.new(project: self.project, user: self.user)
  end

  def submit(attrs)
    # create fund for project
    # attach reward to fund

    self.fund.amount = attrs[:new_fund_form][:amount]
    if attrs[:reward_id].present?
      self.fund.reward_id = Reward.find(attrs[:reward_id]).try(:id)
    end

    self.fund.save

    # add communities to user
    self.communities.each do |community|
      if attrs.has_key?("community_#{community.id}") && attrs["community_#{community.id}"] == "true"
        self.user.communities << community
      end
    end

    self.user.save

  end

end