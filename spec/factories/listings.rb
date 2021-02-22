FactoryBot.define do
  factory :listing do
    user
    zip_code { Faker::Address.zip }
    produce_name { Faker::Food.vegetables }
    produce_type { Faker::Food.fruits }
    description { Faker::Food.description }
    quantity { rand(1..10) }
    unit { 'lbs' }
    date_harvested { "2021-02-20 08:27:22" }
    status { "pending" }

    factory :listing_with_offers do 
      transient do 
        offer_count { 3 }
        offer_user  { user }
      end

      after(:create) do |listing, evaluator|
        create_list(:offer, evaluator.offer_count, listing: listing, user: evaluator.offer_user)
      end
    end   
  end
end
