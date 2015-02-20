class AddFund < ActiveRecord::Migration
  def change
    create_table :funds do |t|
      t.decimal :amount, default: 0
      t.references :user
      t.references :project
      t.references :reward

      t.timestamps
    end

    add_index :funds, :user_id
    add_index :funds, :project_id
  end
end
