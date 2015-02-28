namespace :db do
	namespace :seed do
		task :dev => :environment do
			seed_file = "#{Rails.root}/db/seeds_dev.rb"
			require seed_file
			Rake::Task["db:seed:geo"].invoke
		end

		task :geo => :environment do
			sql_cmd = '.mode tabs\n.import ./vendor/assets/other/CityData.txt locations'
			sh_cmd = "echo \"#{sql_cmd}\" | sqlite3 db/development.sqlite3"

			sh sh_cmd
		end
	end
end
