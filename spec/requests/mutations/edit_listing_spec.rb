require 'rails_helper'

RSpec.describe 'backend can edit a user\'s listing' do 
  it 'with listing id and edited fields' do 
    listing = create(:listing)
    new_quantity = 30
    new_description = "This is a new description."

    mutation_string = <<-GRAPHQL
      mutation {
        updateListing(input: {
          id: #{listing.id},
          quantity: #{new_quantity},
          description: "#{new_description}"}) {
            listing {
              id 
              produceName
              produceType
              quantity
              description
            }
            error
          }
      }
    GRAPHQL

    post graphql_path, params: { query: mutation_string}

    result = JSON.parse(response.body, symbolize_names: true)
    updated_listing = result[:data][:updateListing][:listing]
    error = result[:data][:updateListing][:error]
    
    expect(updated_listing[:produceName]).to eq(listing.produce_name)
    expect(updated_listing[:produceType]).to eq(listing.produce_type)
    expect(updated_listing[:quantity]).to eq(new_quantity)
    expect(updated_listing[:description]).to eq(new_description)
  end

  it 'will return an error if listing does not exist' do 
    listing = create(:listing)
    non_id = 0
    new_quantity = 30
    new_description = "This is a new description."

    mutation_string = <<-GRAPHQL
      mutation {
        updateListing(input: {
          id: #{non_id},
          quantity: #{new_quantity},
          description: "#{new_description}"}) {
            listing {
              id 
              produceName
              produceType
              quantity
              description
            }
            error
          }
      }
    GRAPHQL

    post graphql_path, params: { query: mutation_string}

    result = JSON.parse(response.body, symbolize_names: true)
    updated_listing = result[:data][:updateListing][:listing]
    error = result[:data][:updateListing][:error]

    expect(updated_listing).to be_nil
    expect(error[0]).to eq("Couldn't find Listing with 'id'=#{non_id}")
  end

  it 'will return the same listing without inputs' do 
    listing = create(:listing)

    mutation_string = <<-GRAPHQL
      mutation {
        updateListing(input: {
          id: #{listing.id}}) {
            listing {
              id 
              produceName
              produceType
              quantity
              description
            }
            error
          }
      }
    GRAPHQL

    post graphql_path, params: { query: mutation_string}

    result = JSON.parse(response.body, symbolize_names: true)
    updated_listing = result[:data][:updateListing][:listing]
    error = result[:data][:updateListing][:error]

    expect(error).to be_empty
    expect(updated_listing[:produceName]).to eq(listing.produce_name)
    expect(updated_listing[:produceType]).to eq(listing.produce_type)
    expect(updated_listing[:quantity]).to eq(listing.quantity)
    expect(updated_listing[:description]).to eq(listing.description)
  end
end
