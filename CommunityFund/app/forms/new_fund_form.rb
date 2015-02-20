class NewFundForm < Form
  attr_accessor :amount, :project, :fund

  def initialize(options = {})
    super(options)
    self.project = options[:project]
    self.fund = Fund.new(project: self.project, user: self.user)
  end

  def submit(attrs)
    binding.pry
  end

end