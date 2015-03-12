class FixProjectCommunityColumnName < ActiveRecord::Migration
  def change
    rename_column :projects, :communities_id, :community_id
  end
end
