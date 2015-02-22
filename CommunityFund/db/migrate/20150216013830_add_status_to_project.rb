class AddStatusToProject < ActiveRecord::Migration
  def change
    add_column :projects, :open, :boolean
  end
end
