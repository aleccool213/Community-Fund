class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  has_many :rewards
  accepts_nested_attributes_for :rewards, reject_if: :all_blank, allow_destroy: true

  def initiator
    User.find(self.initiator_id)
  end

  def object
    self
  end
end
