class AddCategories < SeedMigration::Migration
  def up
    Community.create!(name: "Art & Design", description: "Be inspired through innovation and creativity. Support the next big crowdfunding idea!", active: true)
    Community.create!(name: "Education", description: "Support educators and the learning community in their effort to raise money and achieve their fundraising goals.", active: true)
    Community.create!(name: "Environment", description: "Support the environmentalist community in their effort to crowdfund for environment change.", active: true)
    Community.create!(name: "Film & Photography", description: "Over 40K film campaigns chose Indiegogo for crowdfunding. From comedies to horror movies - discover and fund the films you want to see!", active: true)
    Community.create!(name: "Food", description: "Discover passion projects within the food community and help them achieve their fundraising goals.", active: true)
    Community.create!(name: "Gaming", description: "Video to table top, strategy to card games and more. Fuel your gaming passion and support the next big crowdfunding idea here.", active: true)
    Community.create!(name: "Health", description: "Discover the strength of the human spirit. Support those in need by helping them to achieve their fundraising goals.", active: true)
    Community.create!(name: "Music", description: "From song writers, to aspiring musicians, to your favorite artists. Support the next big crowdfunding passion project!", active: true)
    Community.create!(name: "Sports", description: "Be inspired through innovation and creativity. Support the next big crowdfunding idea!", active: true)
    Community.create!(name: "Technology", description: "Hardware, IoT, wearables, gadgets and technology innovations. Join the maker revolution and support the next big crowdfunding idea.", active: true)
  end

  def down
    Community.destroy_all
  end
end
