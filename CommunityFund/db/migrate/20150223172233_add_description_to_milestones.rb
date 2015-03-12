class AddDescriptionToMilestones < ActiveRecord::Migration
  def change	
 	add_column :milestones, :desription, :string
  end
end
