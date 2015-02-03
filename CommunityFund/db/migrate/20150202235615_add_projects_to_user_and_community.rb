class AddProjectsToUserAndCommunity < ActiveRecord::Migration
  def change
    add_column :users, :project_id, :integer
    add_column :communities, :project_id, :integer
  end
end
