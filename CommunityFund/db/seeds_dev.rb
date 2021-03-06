puts "Creating communities...."
Community.all.each do |c|
  #assign a random image to this community
  c.update_attributes(:icon => Faker::Avatar.image(c.name, "50x50"))
end

User.where('username != \'administrator\'').destroy_all

User.create(
  username: "chris",
  email: "chris.sandison@gmail.com",
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
    created_at: Faker::Time.backward(30, :day),
    admin: false)
end

puts "Creating projects..."
Project.destroy_all
50.times do
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

puts "Adding funds..."
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

puts "Adding posts..."

Post.destroy_all
Community.all.each do |community|
  10.times do
    Post.create(
      community_id: community.id,
      user_id: User.all.random.id,
      content: Faker::Lorem.sentence(2)
      )
  end
end

Project.all.each do |project|
  rand(1..10).times do
    Post.create(
      project_id: project.id,
      user_id: User.all.random.id,
      content: Faker::Lorem.sentence(2)
      )
  end
end

puts "Closing some projects, will generate feedbacks..."

Feedback.destroy_all
25.times do
  # select a random project
  project = Project.open.random
  # fund this project

  5.times do
    Fund.create(project: project, user_id: User.all.random.id, amount: (project.target_amount / 2))
  end

  project.close!
end

puts "Submitting some feedbacks..."

20.times do
  Feedback.open.random.update(
    submitted: true,
    rating: rand(1..10),
    description: Faker::Lorem.sentence(2)
    )
end
