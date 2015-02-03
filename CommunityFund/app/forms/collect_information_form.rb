class CollectInformationForm
  include ActiveModel::Model
  include ActionView::Helpers::FormOptionsHelper

  attr_accessor :user, :hometown, :homestate

  def initialize(options = {})
    options.except(:communities).each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end

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
  end
end