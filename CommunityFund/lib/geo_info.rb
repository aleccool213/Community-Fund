class LocationInfo
	attr_reader :id, :country, :city

	def initialize(id, country, city)
		@id = id
		@country = country
		@city = city
	end

	def to_s
		"[#{@id}, #{@country}, #{@city}]"
	end

	def ==(o)
		self.id == o.id
	end
end

module GeoInfo
	def self.countries
		db_query = 'SELECT * FROM locations WHERE city IS NULL ORDER BY country'
		@countries ||= city_database.query(db_query).to_a.map { |r| LocationInfo.new(*r) }
	end

	def self.cities_for_country(country_id)
		db_query = 'SELECT   l2.id, l2.country, l2.city
		            FROM     locations l1 JOIN locations l2 ON l1.country = l2.country
		            WHERE    l1.id = ?
		            AND      l1.city IS NULL
		            AND      l2.city IS NOT NULL
		            ORDER BY l2.city'
		results = city_database.query(db_query, [country_id]).to_a
		return results.map { |r| LocationInfo.new(*r) }
	end

	def self.country_by_name(country_name)
		db_query = 'SELECT   id, country, NULL
		            FROM     locations
		            WHERE    country = ?
		            AND      city IS NULL'
		results = city_database.query(db_query, [country_name]).to_a
		locations = results.map { |r| LocationInfo.new(*r) }
		return locations[0]
	end

	def self.location_by_id(loc_id)
		locations_by_ids([loc_id])[0]
	end

	def self.locations_by_ids(loc_ids)
		if loc_ids.blank?
			return []
		end

		placeholders = (['?'] * loc_ids.length).join(',')
		db_query = "SELECT * FROM locations WHERE id IN (#{placeholders}) ORDER BY country, city"
		results = city_database.query(db_query, loc_ids).to_a
		return results.map { |r| LocationInfo.new(*r) }
	end

	def self.remove_redundancies(loc_ids)
		# World overrides everything
		if loc_ids.include? :WORLD
			return ["WORLD"]
		end

		# Split countries and cities
		locations = locations_by_ids(loc_ids.map(&:to_i))
		countries = locations.select { |c| c.city.blank? }.uniq

		# Only include cities whose country is not already included
		cleaned = countries.map(&:id)
		cities = (locations - countries).uniq
		cities.each do |c|
			if not countries.map(&:country).include? c.country
				cleaned << c.id
			end
		end

		return cleaned
	end

	private
		def self.city_database
			db_path = File.join(Rails.root, 'vendor', 'assets', 'other', 'Cities.dat')
			@database ||= SQLite3::Database.open db_path
		end
end
