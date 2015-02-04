class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :community

  def initiator
    User.find(self.initiator_id)
  end
end
