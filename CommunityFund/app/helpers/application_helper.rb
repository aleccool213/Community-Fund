module ApplicationHelper
  def avatar_url(user, size = 80)
    user.avatar_url(size)
  end
  
  def time_ago(time)
    if time.present?
      time_ago_in_words(time) + " ago"
    else
      "Never"
    end
  end
end