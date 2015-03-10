class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user
      t.references :communities
      t.references :projects

      t.string :content
      t.timestamps
    end
  end
end
