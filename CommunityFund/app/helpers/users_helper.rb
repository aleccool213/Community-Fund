module UsersHelper
  def last_login(user)
    if t = user.current_sign_in_at
      time_ago_in_words(t) + " ago"
    else
      "Never"
    end
  end
end
