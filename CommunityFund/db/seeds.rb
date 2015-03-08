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

  User.create({"admin"=>true, "avatar"=>nil, "community_id"=>nil, "created_at"=>"2015-03-08T18:54:27.262Z", "current_sign_in_at"=>nil, "current_sign_in_ip"=>nil, "email"=>"admin@community-fund.ca", "encrypted_password"=>"$2a$10$c9zosxYIPG5OOtmaAr/NMe45p4gOQVadTRuL8DiMwo8HtCE0ldm6e", "homestate"=>nil, "hometown"=>nil, "last_sign_in_at"=>nil, "last_sign_in_ip"=>nil, "project_id"=>nil, "remember_created_at"=>nil, "reset_password_sent_at"=>nil, "reset_password_token"=>nil, "sign_in_count"=>0, "updated_at"=>"2015-03-08T18:54:27.262Z", "username"=>"administrator"})

  Community.create({"active"=>true, "description"=>"Support the quest of animal lovers and wildlife activists to fundraise for their cause.", "icon"=>nil, "name"=>"Animals", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired through innovation and creativity. Support the next big crowdfunding idea!", "icon"=>nil, "name"=>"Art", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired by creativity. Support the next big crowdfunding passion project!", "icon"=>nil, "name"=>"Comic", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Support the quest of every day people to fundraise for their community and loved ones.", "icon"=>nil, "name"=>"Community", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Discover passion projects within the dance community and help them achieve their fundraising goals.", "icon"=>nil, "name"=>"Dance", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Inspired design and DIY products for home, work and leisure. Fuel your creativity and support the next big crowdfunding idea.", "icon"=>nil, "name"=>"Design", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Support educators and the learning community in their effort to raise money and achieve their fundraising goals.", "icon"=>nil, "name"=>"Education", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Support the environmentalist community in their effort to crowdfund for environment change.", "icon"=>nil, "name"=>"Environment", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Discover passion projects within the fashion community and help them achieve their fundraising goals.", "icon"=>nil, "name"=>"Fashion", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Over 40K film campaigns chose Indiegogo for crowdfunding. From comedies to horror movies - discover and fund the films you want to see!", "icon"=>nil, "name"=>"Film", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Discover passion projects within the food community and help them achieve their fundraising goals.", "icon"=>nil, "name"=>"Food", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Video to table top, strategy to card games and more. Fuel your gaming passion and support the next big crowdfunding idea here.", "icon"=>nil, "name"=>"Gaming", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Discover the strength of the human spirit. Support those in need by helping them to achieve their fundraising goals.", "icon"=>nil, "name"=>"Health", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"From song writers, to aspiring musicians, to your favorite artists. Support the next big crowdfunding passion project!", "icon"=>nil, "name"=>"Music", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired by creativity. Support the next big crowdfunding passion project!", "icon"=>nil, "name"=>"Photography", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Support the quest of politicians and community activists to fundraise for their cause.", "icon"=>nil, "name"=>"Politics", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Discover the aspirations of the faithful. Support those in need by helping them to achieve their fundraising goals.", "icon"=>nil, "name"=>"Religion", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Support inspired athletes, educators and innovators in their effort to raise money and achieve their fundraising goals.", "icon"=>nil, "name"=>"Small Business", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired through innovation and creativity. Support the next big crowdfunding idea!", "icon"=>nil, "name"=>"Sports", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Hardware, IoT, wearables, gadgets and technology innovations. Join the maker revolution and support the next big crowdfunding idea.", "icon"=>nil, "name"=>"Technology", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired through creative storytelling. Support these passion projects and help them reach their fundraising goals.", "icon"=>nil, "name"=>"Theater", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Be inspired through creative storytelling. Support these passion projects and help them reach their fundraising goals.", "icon"=>nil, "name"=>"Transmedia", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"Crowdfunding connects you to the biggest YouTube stars and the best new web creators. Discover and fund the videos you want to see!", "icon"=>nil, "name"=>"Video / Web", "project_id"=>nil, "user_id"=>nil})

  Community.create({"active"=>true, "description"=>"From novelists, to aspiring writers, to your favorite authors. Support the next big crowdfunding passion project!", "icon"=>nil, "name"=>"Writing", "project_id"=>nil, "user_id"=>nil})
end

SeedMigration::Migrator.bootstrap(20150227205720)
