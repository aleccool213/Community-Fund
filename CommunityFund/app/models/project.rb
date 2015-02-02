class Project < ActiveRecord::Base
  belongs_to :community
  belongs_to :user
  # TODO add funders as a has_many
end
