class Project < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :communities
  has_many :rewards
  has_many :funds
  has_many :feedbacks

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

  def donors
    User.where('id in (?)', funds.pluck(:user_id))
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

  def total_amount
    self.funds.sum(:amount)
  end

  def funding_successful?
    self.total_amount >= self.target_amount
  end

  def close!
    self.open = false
    if funding_successful?
      self.funding_successful = true
      notify_users_on_funding!
    end

    self.save
  end

  def average_rating
    submitted_feedback = Feedback.submitted.where(project_id: self.id)
    submitted_feedback.sum(:rating) / submitted_feedback.count
  end

  private

    def notify_users_on_funding!
      # loop through all funding users
      # build a feedback object for each one
      donors.each do |donor|
        Feedback.create(
            user_id: donor.id,
            project_id: self.id,
            submitted: false,
            rating: 0,
            description: "",
            dismissed: false
          )
      end
    end
end
