class AddLocationToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :location, :string
  end
end
