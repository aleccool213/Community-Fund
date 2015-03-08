class AddCurrentFundingToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :current_funding, :decimal
  end
end
