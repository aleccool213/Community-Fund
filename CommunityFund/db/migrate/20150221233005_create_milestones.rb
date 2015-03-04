class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.references :project

      t.integer :percentage, default: 0

      t.timestamps
    end
  end
end
