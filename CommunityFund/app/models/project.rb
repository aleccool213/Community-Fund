class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :rewards
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

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
    if %w(a e i o u).member? self.community.name[0].downcase
      "An #{self.community.name} effort"
    else
      "A #{self.community.name} effort"
    end
  end

  def is_initiator?(user)
    self.initiator_id == user.id
  end
end
