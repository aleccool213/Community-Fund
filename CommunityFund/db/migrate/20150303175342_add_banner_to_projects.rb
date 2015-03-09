class AddBannerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :banner, :string
  end
end
