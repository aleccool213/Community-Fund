class CollectInformationForm < Form

  attr_accessor :hometown, :homestate

  def initialize(options = {})
    super(options.except(:communities))

    initialize_communities(options[:communities])
  end

  def submit(attrs)
    # if we add anything else here then remove it before we start extracting the communities
    add_communities(attrs)

    # TODO check if can be saved, return error if it can't
    user.save
  end
end
