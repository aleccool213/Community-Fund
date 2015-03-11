class Community < ActiveRecord::Base
  has_many :users
  has_and_belongs_to_many :projects
  has_many :posts

  mount_uploader :banner, AvatarUploader

  scope :active, -> { where(active: true)}

  def total
    self.projects.map(&:total_amount).inject(0, &:+)
  end
end
