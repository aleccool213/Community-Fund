class Feedback < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :not_dismissed, -> { where(dismissed: false)}
  scope :open, -> { where(submitted: false)}
  scope :submitted, -> {where(submitted: true)}
end
