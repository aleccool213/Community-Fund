class Community < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :projects

  scope :active, -> { where(active: true)}
end
