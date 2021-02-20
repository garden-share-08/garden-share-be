FactoryBot.define do
  factory :offer do
    user
    listing
    produce_name { Faker::Food.vegetables }
    produce_type { Faker::Food.fruits }
    description { Faker::Food.description }
    quantity { rand(1..10) }
    unit { 'lbs' }
    date_harvested { "2021-02-20 12:30:03" }
    status { "pending" }
  end
end
