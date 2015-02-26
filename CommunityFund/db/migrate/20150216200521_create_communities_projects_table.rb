class CreateCommunitiesProjectsTable < ActiveRecord::Migration
  def change
    create_table :communities_projects, id: false do |t|
      t.belongs_to :community, index: true
      t.belongs_to :project, index: true
    end
  end
end
