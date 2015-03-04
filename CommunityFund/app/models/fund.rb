class Fund < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_one :reward

  #always gonna be a milestone after a Fund is saved
  after_save :add_milestone

  #adds a milestone the project if it qualifies
  def add_milestone
    completion_status = self.project.completion_status
    latestMilestone = self.project.milestones.find_by(:percentage => completion_status[:percentage])
    if latestMilestone == nil
      newMilestone = Milestone.create(
        :project_id => self.project_id, 
        :percentage => completion_status[:percentage],
        :description => completion_status[:status],
        :fund_id => self.id
        )
    end
  end


end
