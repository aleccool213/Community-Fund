class ChangePercentageToDecimal < ActiveRecord::Migration
  def change
  	change_column :milestones, :percentage, :decimal
  end
end
