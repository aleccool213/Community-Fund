class AddAdminUser < SeedMigration::Migration
  def up
    User.create!(username: "administrator",
                email: "admin@community-fund.ca",
                password: "password1-",
                password_confirmation: "password1-",
                admin: true)
  end

  def down
    User.destroy_all
  end
end
