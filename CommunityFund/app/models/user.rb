class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :timeoutable, :omniauthable,
         omniauth_providers: [:facebook]

  validates :username, presence: true, uniqueness: true,
            format: { with: /\A[A-Za-z0-9_]+\z/,
                      message: "Only alphanumerical characters and underscores allowed." }
  

  has_and_belongs_to_many :communities
  has_many :projects
  has_many :funds
  has_many :feedbacks
  has_many :reports
  has_many :posts
  
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
      "No feedbacks are available."
    end
  end

  def projects_funded
    Project.find(self.funds.pluck(:project_id))
  end

  def avatar_url(size = 80)
     default_url = "mm"  #"#{root_url}images/guest.png"
    if url = avatar.url
      url
    else
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
  end

  def geo_community
    if self.location.present?
        return GeoInfo::location_by_id(self.location)
    end

    return nil
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.first_name
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
    end
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
