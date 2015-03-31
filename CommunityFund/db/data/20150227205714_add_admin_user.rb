class AddAdminUser < SeedMigration::Migration
  def up
    User.create!(username: "administrator",
                email: "admin@community-fund.ca",
                password: "password",
                password_confirmation: "password",
                admin: true)
  end

  def down
    User.destroy_all
  end
end
