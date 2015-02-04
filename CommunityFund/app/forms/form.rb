class Form
  include ActiveModel::Model
  include ActionView::Helpers::FormOptionsHelper

  attr_accessor :user

  def initialize(options = {})
    options.except(:communities).each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end
  end

  def initialize_communities(options = {})
    options.each do |community|
      self.class.send(:attr_accessor, "community_#{community.id}")
      instance_variable_set("@community_#{community.id}", false)
    end
  end

  def add_communities(attrs)
    attrs.each do |community_key, value|
      if community_key =~ /community_/ && value == "1"
        community = Community.active.find(community_key.gsub(/community_/, ''))
        user.communities << community unless user.in_community?(community)
      end
    end
  end
end