namespace :db do
	namespace :seed do
		task :dev => :environment do
			seed_file = "#{Rails.root}/db/seeds_dev.rb"
			require seed_file
		end
	end
end
