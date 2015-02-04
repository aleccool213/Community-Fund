class NewProjectForm < Form

  attr_accessor :name, :description

  def initialize(options = {})
    super(options)
    initialize_communities(options[:communities])
  end

  def submit
    project = Project.create(initiator_id: user.id)

    add_communities(attrs)
  end
end