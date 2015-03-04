module UsersHelper
  def get_reward(fund)
    if r = Reward.find_by_id(fund.reward_id)
      "Reward: #{r.description}"
    else
      ""
    end
  end
end
