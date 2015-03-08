class AddGeoCommunityToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :hometown, :string
    remove_column :users, :homestate, :string
    add_column :users, :location, :string
  end
end
