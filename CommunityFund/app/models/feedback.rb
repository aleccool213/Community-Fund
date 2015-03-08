class Feedback < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :not_dismissed, -> { where(dismissed: false)}
  scope :open, -> { where(submitted: false)}
  scope :submitted, -> {where(submitted: true)}

  after_save :add_milestone

  #Creates a milestone when a feedback is given
  def add_milestone
    Milestone.create(
      :project_id => self.project_id, 
      :milestone_type => "Feedback",
      :description => self.user.username + " has submitted feedback on " + self.project.name
    )
  end

end
