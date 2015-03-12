class AddFinalDateToProject < ActiveRecord::Migration
  def change
    add_column :projects, :completion_date, :datetime
  end
end
