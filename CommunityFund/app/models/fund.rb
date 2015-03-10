class Fund < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :reward

  #always gonna be a milestone after a Fund is saved
  after_save :add_milestone

  #adds a milestone the project if it qualifies
  def add_milestone
    new_completion_status = self.project.completion_status
    latestMilestone = self.project.milestones.find_by(:percentage => new_completion_status[:percentage])
    if latestMilestone == nil
      newMilestone = Milestone.create(
        :project_id => self.project_id, 
        :milestone_type => "Fund",
        :percentage => new_completion_status[:percentage],
        :description => new_completion_status[:status],
        :fund_id => self.id
        )
    end
  end


end
