class AddGeoCommunitiesStrToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :geo_communities_str, :string, null: false, default: ""
  end
end
