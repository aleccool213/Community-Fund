# Configure seed_migrations
SeedMigration.config do |c|
    c.ignore_ids = true
end

SeedMigration.register User
SeedMigration.register Community
