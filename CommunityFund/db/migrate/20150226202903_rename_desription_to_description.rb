class RenameDesriptionToDescription < ActiveRecord::Migration
  def change
  	rename_column :milestones, :desription, :description
  end
end
