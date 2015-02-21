module ProjectHelper
  def user_has_funded?
    current_user.funds.where(project_id: @project.id).present?
  end
end
