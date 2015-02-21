class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user
      t.references :project

      t.boolean :submitted, default: false
      t.integer :rating, default: 0
      t.string :description

      t.timestamps
    end

    add_index :feedbacks, :user_id
    add_index :feedbacks, :project_id
  end
end
