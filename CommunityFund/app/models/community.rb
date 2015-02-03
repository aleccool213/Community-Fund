class Community < ActiveRecord::Base
  has_many :users
  has_many :projects

  scope :active, -> { where(active: true)}
end
