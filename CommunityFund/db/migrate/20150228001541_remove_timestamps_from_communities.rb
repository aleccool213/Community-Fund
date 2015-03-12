class RemoveTimestampsFromCommunities < ActiveRecord::Migration
  def change
    remove_column :communities, :created_at, :string
    remove_column :communities, :updated_at, :string
  end
end
