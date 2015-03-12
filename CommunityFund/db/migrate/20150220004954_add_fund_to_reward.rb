class AddFundToReward < ActiveRecord::Migration
  def change
    add_reference :rewards, :funds, index: true
  end
end
