FactoryBot.define do
  factory :listing do
    user_id { nil }
    zip_code { "MyString" }
    produce_name { "MyString" }
    produce_type { "MyString" }
    description { "MyString" }
    quantity { "" }
    unit { "MyString" }
    date_harvested { "2021-02-20 08:27:22" }
    status { "MyString" }
  end
end
