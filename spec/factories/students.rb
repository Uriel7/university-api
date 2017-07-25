FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    surname { Faker::Name.last_name }
    birthdate { Faker::Date.birthday(18,28) }
  end
end