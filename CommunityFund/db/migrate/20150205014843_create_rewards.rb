class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.decimal :reward_level
      t.text :description
      t.references :user
      t.references :project
      t.timestamps
    end
  end
end
