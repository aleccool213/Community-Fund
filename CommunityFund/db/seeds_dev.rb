# Add random images for icons to communties
Community.all.each do |c|
  #assign a random image to this community
  c.update_attributes(:icon => Faker::Avatar.image(c.name, "50x50"))
end

User.where('username != "administrator"').destroy_all

User.create(
  username: "TimoVink",
  email: "timovink@gmail.com",
  password: "password1-",
  password_confirmation: "password1-")

User.create(
  username: "chris",
  email: "chris@community-fund.ca",
  password: "password",
  password_confirmation: "password",
  admin: true)

100.times do
  User.create(
    username: Faker::Internet.user_name,
    email: Faker::Internet.free_email,
    password: "password1-",
    password_confirmation: "password1-",
    last_sign_in_ip: Faker::Internet.ip_v4_address,
    created_at: Faker::Time.backward(30, :day))
end

Project.destroy_all
20.times do
  Project.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    created_at: Faker::Time.backward(30, :day),
    user_id: User.all.random.id,
    target_amount: rand(100...6000),
    communities: Community.order_by_rand.limit(2),
    completion_date: Faker::Time.backward(20, :day) + 1.month,
    open: true)
end

Fund.destroy_all
fund_project = false
user_index = 0
users = User.all
Project.all.each do |project|
  (fund_project ? 4 : 3).times do
    Fund.create(
      project: project,
      user: users[user_index],
      amount: (project.target_amount / 4)
      )
    user_index += 1
  end
  fund_project = !fund_project
end
