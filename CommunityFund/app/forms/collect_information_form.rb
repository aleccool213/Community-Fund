class CollectInformationForm < Form
  attr_accessor :hometown, :homestate

  def initialize(options = {})
    super(options.except(:communities))

    options[:communities].each do |community|
      self.class.send(:attr_accessor, "community_#{community.id}")
      instance_variable_set("@community_#{community.id}", false)
    end
  end

  def submit(attrs)
    
    # TODO check if hometown and homestate exist
    user.hometown = attrs.delete(:hometown)
    user.homestate = attrs.delete(:homestate)

    # if we add anything else here then remove it before we start extracting the communities
    attrs.each do |community_key, value|
      if value == "1"
        community = Community.active.find(community_key.gsub(/community_/, ''))
        user.communities << community unless user.in_community?(community)
      end
    end

    # TODO check if can be saved, return error if it can't
    user.save
  end
  
end