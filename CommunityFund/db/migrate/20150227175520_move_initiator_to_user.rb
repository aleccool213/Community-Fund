class MoveInitiatorToUser < ActiveRecord::Migration
  def change
    Project.all.each do |project|
      if project.initiator_id.present?
        project.update(user_id: User.find_by_id(project.initiator_id).id)
      end
    end

    remove_column :projects, :initiator_id
  end
end
