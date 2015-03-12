class AddHomestateToUser < ActiveRecord::Migration
  def change
    add_column :users, :homestate, :string
  end
end
