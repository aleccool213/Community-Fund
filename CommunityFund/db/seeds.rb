Community.destroy_all
Community.create(name: "Science and Technology", description: "", active: true)
Community.create(name: "Automotive", description: "", active: true)
Community.create(name: "Sports", description: "", active: true)
Community.create(name: "Health", description: "", active: true)
Community.create(name: "Education", description: "", active: true)

User.destroy_all
User.create(username: "administrator", email: "admin@community-fund.ca",
            password: "password1-", password_confirmation: "password1-",
			admin: true)
User.create(username: "TimoVink", email: "timovink@gmail.com",
			password: "password1-", password_confirmation: "password1-")
100.times do
	User.create(username: Faker::Internet.user_name, email: Faker::Internet.free_email,
				password: "password1-", password_confirmation: "password1-",
                last_sign_in_ip: Faker::Internet.ip_v4_address,
				created_at: Faker::Time.backward(30, :day))
end

Project.destroy_all
20.times do
	Project.create(name: Faker::Commerce.product_name,
                   description: Faker::Lorem.paragraph,
                   created_at: Faker::Time.backward(30, :day))
end
