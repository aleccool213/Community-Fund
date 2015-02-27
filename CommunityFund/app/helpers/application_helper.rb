module ApplicationHelper
  def avatar_url(user, size = 80)
    default_url = "mm"  #"#{root_url}images/guest.png"
    native_url = user.avatar and native_url.avatar
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
  end
end