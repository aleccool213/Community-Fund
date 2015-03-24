class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  belongs_to :project

  def title_text
    obj = get_object
    text = "#{self.user.username.capitalize} "
    text += "(Initiator) " if obj.class == Project && obj.is_initiator?(self.user)
    text += "(Administrator) " if self.user.admin?
    text += "(Funder) " if obj.class == "Project" && Fund.where(project_id: obj.id, user_id: self.user.id).present?
    text
  end

  def get_object
    community_post? ? self.community : self.project
  end

  def community_post?
    self.community_id.present?
  end

  def project_post?
    self.project_id.present?
  end
end
