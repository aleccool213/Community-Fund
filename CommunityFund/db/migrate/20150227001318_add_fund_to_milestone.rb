class AddFundToMilestone < ActiveRecord::Migration
  def change
  	change_table :milestones do |t|
  		t.references :fund

  	end
  end
end
