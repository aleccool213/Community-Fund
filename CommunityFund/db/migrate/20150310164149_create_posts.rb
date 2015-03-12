class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :community
      t.references :project

      t.string :content
      t.timestamps
    end
  end
end
