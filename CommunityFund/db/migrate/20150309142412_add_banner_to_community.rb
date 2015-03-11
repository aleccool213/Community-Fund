class AddBannerToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :banner, :string
  end
end
