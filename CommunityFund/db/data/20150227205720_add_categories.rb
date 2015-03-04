class AddCategories < SeedMigration::Migration
  def up
    Community.create!(name: "Animals", description: "Support the quest of animal lovers and wildlife activists to fundraise for their cause.", active: true)
    Community.create!(name: "Art", description: "Be inspired through innovation and creativity. Support the next big crowdfunding idea!", active: true)
    Community.create!(name: "Comic", description: "Be inspired by creativity. Support the next big crowdfunding passion project!", active: true)
    Community.create!(name: "Community", description: "Support the quest of every day people to fundraise for their community and loved ones.", active: true)
    Community.create!(name: "Dance", description: "Discover passion projects within the dance community and help them achieve their fundraising goals.", active: true)
    Community.create!(name: "Design", description: "Inspired design and DIY products for home, work and leisure. Fuel your creativity and support the next big crowdfunding idea.", active: true)
    Community.create!(name: "Education", description: "Support educators and the learning community in their effort to raise money and achieve their fundraising goals.", active: true)
    Community.create!(name: "Environment", description: "Support the environmentalist community in their effort to crowdfund for environment change.", active: true)
    Community.create!(name: "Fashion", description: "Discover passion projects within the fashion community and help them achieve their fundraising goals.", active: true)
    Community.create!(name: "Film", description: "Over 40K film campaigns chose Indiegogo for crowdfunding. From comedies to horror movies - discover and fund the films you want to see!", active: true)
    Community.create!(name: "Food", description: "Discover passion projects within the food community and help them achieve their fundraising goals.", active: true)
    Community.create!(name: "Gaming", description: "Video to table top, strategy to card games and more. Fuel your gaming passion and support the next big crowdfunding idea here.", active: true)
    Community.create!(name: "Health", description: "Discover the strength of the human spirit. Support those in need by helping them to achieve their fundraising goals.", active: true)
    Community.create!(name: "Music", description: "From song writers, to aspiring musicians, to your favorite artists. Support the next big crowdfunding passion project!", active: true)
    Community.create!(name: "Photography", description: "Be inspired by creativity. Support the next big crowdfunding passion project!", active: true)
    Community.create!(name: "Politics", description: "Support the quest of politicians and community activists to fundraise for their cause.", active: true)
    Community.create!(name: "Religion", description: "Discover the aspirations of the faithful. Support those in need by helping them to achieve their fundraising goals.", active: true)
    Community.create!(name: "Small Business", description: "Support inspired athletes, educators and innovators in their effort to raise money and achieve their fundraising goals.", active: true)
    Community.create!(name: "Sports", description: "Be inspired through innovation and creativity. Support the next big crowdfunding idea!", active: true)
    Community.create!(name: "Technology", description: "Hardware, IoT, wearables, gadgets and technology innovations. Join the maker revolution and support the next big crowdfunding idea.", active: true)
    Community.create!(name: "Theater", description: "Be inspired through creative storytelling. Support these passion projects and help them reach their fundraising goals.", active: true)
    Community.create!(name: "Transmedia", description: "Be inspired through creative storytelling. Support these passion projects and help them reach their fundraising goals.", active: true)
    Community.create!(name: "Video / Web", description: "Crowdfunding connects you to the biggest YouTube stars and the best new web creators. Discover and fund the videos you want to see!", active: true)
    Community.create!(name: "Writing", description: "From novelists, to aspiring writers, to your favorite authors. Support the next big crowdfunding passion project!", active: true)
  end

  def down
    Community.destroy_all
  end
end
