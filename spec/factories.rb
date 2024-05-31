FactoryBot.define do
  factory :author do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
  end

  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
