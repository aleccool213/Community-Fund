# encoding: UTF-8
# This file is auto-generated from the current content of the database. Instead
# of editing this file, please use the migrations feature of Seed Migration to
# incrementally modify your database, and then regenerate this seed file.
#
# If you need to create the database on another system, you should be using
# db:seed, not running all the migrations from scratch. The latter is a flawed
# and unsustainable approach (the more migrations you'll amass, the slower
# it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Base.transaction do

  User.create({"admin"=>true, "avatar"=>nil, "community_id"=>nil, "created_at"=>"2015-03-31T23:08:17.907Z", "current_sign_in_at"=>nil, "current_sign_in_ip"=>nil, "description"=>nil, "email"=>"admin@community-fund.ca", "encrypted_password"=>"$2a$10$u5M4kTYXPs4tSlS6.XOwB.lgYVNgQXlSxcvHihbBEhXJIqM2hhV0K", "facebook_url"=>nil, "first_name"=>nil, "last_name"=>nil, "last_sign_in_at"=>nil, "last_sign_in_ip"=>nil, "location"=>nil, "project_id"=>nil, "provider"=>nil, "remember_created_at"=>nil, "reset_password_sent_at"=>nil, "reset_password_token"=>nil, "sign_in_count"=>0, "twitter_url"=>nil, "uid"=>nil, "updated_at"=>"2015-03-31T23:08:17.907Z", "username"=>"administrator"})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Be inspired through innovation and creativity. Support the next big crowdfunding idea!", "icon"=>nil, "name"=>"Art & Design", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Support educators and the learning community in their effort to raise money and achieve their fundraising goals.", "icon"=>nil, "name"=>"Education", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Support the environmentalist community in their effort to crowdfund for environment change.", "icon"=>nil, "name"=>"Environment", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Over 40K film campaigns chose Indiegogo for crowdfunding. From comedies to horror movies - discover and fund the films you want to see!", "icon"=>nil, "name"=>"Film & Photography", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Discover passion projects within the food community and help them achieve their fundraising goals.", "icon"=>nil, "name"=>"Food", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Video to table top, strategy to card games and more. Fuel your gaming passion and support the next big crowdfunding idea here.", "icon"=>nil, "name"=>"Gaming", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Discover the strength of the human spirit. Support those in need by helping them to achieve their fundraising goals.", "icon"=>nil, "name"=>"Health", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"From song writers, to aspiring musicians, to your favorite artists. Support the next big crowdfunding passion project!", "icon"=>nil, "name"=>"Music", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Be inspired through innovation and creativity. Support the next big crowdfunding idea!", "icon"=>nil, "name"=>"Sports", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "banner"=>nil, "description"=>"Hardware, IoT, wearables, gadgets and technology innovations. Join the maker revolution and support the next big crowdfunding idea.", "icon"=>nil, "name"=>"Technology", "project_id"=>nil, "user_id"=>nil})
end

SeedMigration::Migrator.bootstrap(20150227205720)
