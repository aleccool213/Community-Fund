class RemoveLocationFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :location, :string
  end
end
