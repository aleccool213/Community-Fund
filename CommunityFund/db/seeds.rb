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
