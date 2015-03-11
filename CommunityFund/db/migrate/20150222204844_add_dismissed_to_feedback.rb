class AddDismissedToFeedback < ActiveRecord::Migration
  def change
    add_column :feedbacks, :dismissed, :boolean, default: false
  end
end
