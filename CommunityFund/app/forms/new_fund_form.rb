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

  #add milestone if there is one
  percentage = self.project.completion_status['percentage']
  latestMilestone = self.project.milestones.find_by(:percentage => percentage)
  if (self.project.total_amount > percentage) 
    and latestMilestone.exists?
    newMilestone = Milestone.new
    newMilestone.percentage = percentage
    newMilestone.save
  end

  # add communities to user
  self.communities.each do |community|
    if attrs.has_key?("community_#{community.id}") && attrs["community_#{community.id}"] == "true"
      self.user.communities << community
    end
  end

  self.user.save

  end

end