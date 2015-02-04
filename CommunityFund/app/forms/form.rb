class Form
  include ActiveModel::Model
  include ActionView::Helpers::FormOptionsHelper

  attr_accessor :user

  def initialize(options = {})
    options.except(:communities).each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end
  end
end