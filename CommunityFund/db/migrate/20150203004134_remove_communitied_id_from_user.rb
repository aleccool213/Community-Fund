class RemoveCommunitiedIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :communities_id
  end
end
