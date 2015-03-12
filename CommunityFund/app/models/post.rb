class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :community
  belongs_to :project
end
