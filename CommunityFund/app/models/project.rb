class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :communities
  has_many :rewards
  has_many :funds
  has_many :feedbacks
  has_many :milestones


  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  scope :open, -> { where(open: true)}

  def initiator
    User.find(self.initiator_id)
  end

  def self.minimum_start_year
    DateTime.now.year
  end

  def self.maximum_end_year
    DateTime.now.year + 10
  end

  def description_lead
    if %w(a e i o u).member? self.communities.first.name[0].downcase
      "An"
    else
      "A"
    end
  end

  def is_initiator?(user)
    self.initiator_id == user.id
  end

  def hashtag_community(community)
    "##{community.name.gsub(/ /, "")}"
  end

  def completion_date_for_display
    "At midnight on #{completion_date.strftime('%B %m, %Y')}"
  end

  def closed?
    !open?
  end

  # Returns a string containing the project status
  def completion_status
    returnValue = {status: '' , percentage: 0.0}
    #status
    if self.target_amount and self.total_amount
      twenty_five = self.target_amount*0.25
      fifty = self.target_amount*0.5
      seventy_five = self.target_amount*0.75
      if self.total_amount.to_s.to_i > seventy_five
        returnValue[:percentage] = 0.75
        returnValue[:status] = "Project is almost funded! (Over 75% funded)"
      elsif self.total_amount.to_s.to_i > fifty
        returnValue[:percentage] = 0.50
        returnValue[:status] = "Project is half way there! (Over 50% funded)"
      elsif self.total_amount.to_s.to_i >= twenty_five
        returnValue[:percentage] = 0.25
        returnValue[:status] = "Project is starting to shape up! (Over 25% funded)"
      elsif self.total_amount.to_s.to_i < twenty_five
        returnValue[:percentage] = 0.01
        returnValue[:status] = "Project has been created! (0-25% funded)"
      else
        returnValue[:percentage] = 0.0
        returnValue[:status] = "Project has no funding!"
      end
      returnValue
    else
      nil
    end

  end

  def total_amount
    self.funds.sum(:amount)
  end

  def funding_successful?
    self.total_amount >= self.target_amount
  end

  def notify_users_on_funding
    # create feedback for users - do this in another branch (model already initialized)
  end

  def complete_funding
    self.open = false
    if funding_successful?
      self.funding_successful = true
      notify_users_on_funding
    end

    self.save
  end
end
