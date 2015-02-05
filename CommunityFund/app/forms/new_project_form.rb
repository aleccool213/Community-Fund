class NewProjectForm < Form

  attr_accessor :name, :description, :project

  def initialize(options = {})
    super(options)
    initialize_communities(options[:communities])
    self.project = Project.new()
    self.project.rewards = [Reward.new()]
  end

  def submit
    # TODO revisit how the form will handle this thing
    project = Project.create(initiator_id: user.id)
    add_communities(attrs)
  end
end