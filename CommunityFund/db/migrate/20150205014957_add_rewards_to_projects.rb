class AddRewardsToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :rewards, index: true
  end
end
