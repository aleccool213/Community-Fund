class Feedback < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :not_dismissed, -> { where(dismissed: false)}
end
