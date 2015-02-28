module GeoInfo
	def self.countries
		db_query = "SELECT DISTINCT name FROM country_details ORDER BY name"
		@countries ||= city_database.query(db_query).to_a
	end

	def self.cities_for_country(country_name)
		db_query = 'SELECT id, city FROM cities WHERE country = ? ORDER BY city'
		city_database.query(db_query, [country_name]).to_a
	end

	def self.cities_by_ids(city_ids)
		db_query = 'SELECT id, country, city FROM cities WHERE id IN ? ORDER BY city'
		city_database.query(db_query, city_ids).to_a
	end

	private
		def self.city_database
			db_path = File.join(Rails.root, 'vendor', 'assets', 'other', 'Cities.dat')
			@database ||= SQLite3::Database.open db_path
		end
end
