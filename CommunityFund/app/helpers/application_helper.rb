module ApplicationHelper
  def avatar_url(user, size = 80)
    default_url = "mm"  #"#{root_url}images/guest.png"
    if url = user.avatar.url
      url
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
  end
  
  def time_ago(time)
    if t = time
      time_ago_in_words(t) + " ago"
    else
      "Never"
    end
  end
end