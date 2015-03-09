class Community < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :projects

  mount_uploader :banner, AvatarUploader

  scope :active, -> { where(active: true)}

  def total
  	total = 0
  	self.projects.map do |p|
      total = total + p.total_amount
    end
    total
    #self.funds.sum(:amount)
  end
end
