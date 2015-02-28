class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :asciiname
      t.text :alternatenames
      t.string :latitude
      t.string :longitude
      t.string :feature_class
      t.string :feature_code
      t.string :country_code
      t.string :cc2
      t.string :admin1_code
      t.string :admin2_code
      t.string :admin3_code
      t.string :admin4_code
      t.integer :population
      t.integer :elevation
      t.integer :dem
      t.string :timezone
      t.string :updated_at
    end

    add_index :locations, :country_code
    add_index :locations, :asciiname
  end
end
