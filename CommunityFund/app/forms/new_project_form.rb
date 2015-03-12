class NewProjectForm < Form

  attr_accessor :name, :description, :project
  def initialize(options = {})
    super(options)
    initialize_communities(options[:communities])
    self.project = Project.new()
  end

  def submit(attrs)

    # separate our parameters for building referrential objects
    project_params = attrs[:project]
    reward_params = attrs[:project][:rewards_attributes]

    # create initial project object
    self.project = Project.create(
      name: project_params[:name],
      description: project_params[:description],
      completion_date: DateTime.new(project_params["completion_date(1i)"].to_i, project_params["completion_date(2i)"].to_i, project_params["completion_date(3i)"].to_i),
      user: user,
      target_amount: project_params["target_amount"],
      open: true
      )

    project.banner = project_params["banner"] if project_params.has_key?("banner")

    # add communities to project
    Community.active.each do |community|
      project.communities << community if attrs["community_#{community.id}"] == "true"
      user.communities << community if (attrs["community_#{community.id}"] == "true") && !user.in_community?(community)
    end

    # build reward levels for project
    if reward_params.present?
      reward_params.each do |reward|
        reward = reward[1] # this is being created as a two item array, just grab the reward params
        self.project.rewards << Reward.create(
            reward_level: reward[:reward_level],
            description: reward[:description],
            project_id: self.project
          ) if (reward[:reward_level].present? && reward[:description].present?)
      end
    end

    self.project.save

  end
end