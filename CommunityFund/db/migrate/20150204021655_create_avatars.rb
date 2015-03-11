class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.belongs_to :user
      t.string :avatar
      t.timestamps
    end
  end
end
