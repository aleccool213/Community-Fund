class EditProjectForm < Form

  attr_accessor :name, :description, :project

  def initialize(options = {})
    super(options)
  end

  def submit(attrs)
    # separate our parameters for building referrential objects
    project_params = attrs[:project]
    reward_params = attrs[:project][:rewards_attributes]

    # create initial project object
    self.project.update(
      name: project_params[:name],
      description: project_params[:description],
      completion_date: DateTime.new(project_params["completion_date(1i)"].to_i, project_params["completion_date(2i)"].to_i, project_params["completion_date(3i)"].to_i),
      target_amount: project_params["target_amount"],
      )

    if reward_params.present?
      reward_params.values.each do |reward|
        #nested attributes stores the id of the reward if it exists (reward["id"]), otherwise just add it
        # will have reward["_destroy"] = "1" if it should be removed
        if reward.has_key? "id"
          if reward.has_key?("_destroy") && (reward["_destroy"] == "1")
            project.rewards.find(reward["id"]).destroy
          else
            project.rewards.find(reward["id"]).update(
              reward_level: reward[:reward_level],
              description: reward[:description]
              )
          end
        else
          project.rewards << Reward.create(
              reward_level: reward[:reward_level],
              description: reward[:description]
            ) if (reward[:reward_level].present? && reward[:description].present?)
        end
      end
    end

    project.save

  end
end