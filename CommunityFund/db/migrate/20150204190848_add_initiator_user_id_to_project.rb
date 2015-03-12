class AddInitiatorUserIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :initiator_id, :integer
  end
end
