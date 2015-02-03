FactoryGirl.define do
  factory :user do
    username    "johndoe"
    email       "johndoe@mailer.com"
    password    "password"
  end

  factory :community do
    name        "Example Community"
    active      true
  end
end