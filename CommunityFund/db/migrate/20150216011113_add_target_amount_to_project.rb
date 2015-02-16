class AddTargetAmountToProject < ActiveRecord::Migration
  def change
    add_column :projects, :target_amount, :decimal
  end
end
