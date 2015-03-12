class CreateUsersCommunities < ActiveRecord::Migration
  def change
    create_table :communities_users, id: false do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :community, index: true
    end
  end
end
