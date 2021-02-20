FactoryBot.define do
  factory :listing do
    user 
    zip_code { Faker::Address.zip }
    produce_name { Faker::Food.vegetables }
    produce_type { Faker::Food.fruits }
    description { Faker::Food.description }
    quantity { rand(1..10) }
    unit { 'lbs'}
    date_harvested { "2021-02-20 08:27:22" }
    status { "pending" }
  end
end
