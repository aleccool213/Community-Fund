class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  validates :username, presence: true, uniqueness: true, 
            format: { with: /\A[A-Za-z0-9_]+\z/,
                      message: "Only alphanumerical characters and underscores allowed." }

  has_many :communities
  has_many :projects
  has_many :funds
  has_many :feedbacks
  has_many :reports
  
  mount_uploader :avatar, AvatarUploader

  def in_community?(community)
    communities.include? community
  end

  def fund_for_project(project)
    funds.where(project_id: project.id).last
  end

  def has_reported?(report_type, obj_id)
    results = reports.where(reported_obj_type: report_type, reported_obj_id: obj_id)
    return (not results.blank?)
  end

  def feedback_button_text
    if feedbacks.count >= 1
      "You have (#{feedbacks.count}) projects to give feedback on"
    else
      "No feedbacks are available"
    end
  end

  def projects_funded
    Project.find(self.funds.pluck(:project_id))
  end

end
