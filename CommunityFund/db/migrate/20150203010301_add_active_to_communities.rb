class AddActiveToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :active, :boolean, default: true
  end
end
