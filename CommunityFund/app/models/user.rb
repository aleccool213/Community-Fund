class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  validates :username, presence: true

  has_many :communities
  has_many :projects
  has_many :funds
  has_many :feedbacks
  has_many :reports

  def in_community?(community)
    communities.include? community
  end

  def fund_for_project(project)
    funds.where(project_id: project.id).last
  end

  def feedback_button_text
    if feedbacks.count >= 1
      "Send Feedback (#{feedbacks.count})"
    else
      "Send Feedback"
    end
  end
end
