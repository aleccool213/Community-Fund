class CollectInformationForm < Form

  attr_accessor :hometown, :homestate

  def initialize(options = {})
    super(options.except(:communities))

    initialize_communities(options[:communities])
  end

  def submit(attrs)
    
    # TODO check if hometown and homestate exist
    user.hometown = attrs.delete(:hometown)
    user.homestate = attrs.delete(:homestate)

    # if we add anything else here then remove it before we start extracting the communities
    add_communities_and_users(attrs)

    # TODO check if can be saved, return error if it can't
    user.save
  end
  
end