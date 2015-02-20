class Fund < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_one :reward

  def self.minimum_amount
    10
  end
end
