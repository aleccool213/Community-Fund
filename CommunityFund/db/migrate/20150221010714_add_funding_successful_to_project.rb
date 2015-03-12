class AddFundingSuccessfulToProject < ActiveRecord::Migration
  def change
    add_column :projects, :funding_successful, :boolean, default: false
  end
end
