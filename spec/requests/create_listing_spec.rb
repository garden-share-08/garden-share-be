require 'rails_helper'

RSpec.describe 'backend createListing mutation request' do
  it 'creates a unique listing' do
    listing = build(:listing)
    query_string = <<-GRAPHQL
     mutation {
       createListing(input:{
           userId: 1,
           zipCode: "#{listing.zip_code}",
           produceName: "#{listing.produce_name}",
           description: "#{listing.description}",
           produceType: "#{listing.produce_type}",
           quantity: #{listing.quantity}}) {
          listing {
            quantity
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    require "pry"; binding.pry
    result = JSON.parse(response.body, symbolize_names: true)
    listing_info = result[:data][:createListing][:listing]
    error = result[:data][:createListing][:error]

    expect(error).to be_empty
    expect(user_info[:firstName]).to eq(user.first_name)
    expect(user_info[:lastName]).to eq(user.last_name)
    expect(user_info[:email]).to eq(user.email)

  end
end
