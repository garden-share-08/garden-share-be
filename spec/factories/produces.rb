FactoryBot.define do
  factory :produce do
    name { Faker::Food.vegetables }
    image { "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg" }
  end
end
