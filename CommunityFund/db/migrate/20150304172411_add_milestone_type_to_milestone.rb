class AddMilestoneTypeToMilestone < ActiveRecord::Migration
  def change
    add_column :milestones, :milestone_type, :string
  end
end
