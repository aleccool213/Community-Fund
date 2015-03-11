class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :reported_obj_type, null: false
      t.integer :reported_obj_id, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
