class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user
      t.references :communities

      t.timestamps
    end
  end
end
