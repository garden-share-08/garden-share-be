require 'rails_helper'

RSpec.describe 'backend createListing mutation request' do
  it 'creates a listing' do
    user = create(:user)
    listing = create(:listing)
    query_string = <<-GRAPHQL
     mutation {
       createListing(input: {
        userId: #{user.id}, 
        zipCode: "#{listing.zip_code}", 
        produceName: "#{listing.produce_name}", 
        produceType: "#{listing.produce_type}", 
        description: "#{listing.description}", 
        quantity: #{listing.quantity}, 
        unit: "#{listing.unit}",
        dateHarvested: "#{listing.date_harvested}"}) {
          listing {
            zipCode
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    listing_info = result[:data][:createListing][:listing]
    error = result[:data][:createListing][:error]

    expect(error).to be_empty
    expect(listing_info[:zipCode]).to eq(listing.zip_code)
    expect(listing_info[:produceName]).to eq(listing.produce_name)
    expect(listing_info[:produceType]).to eq(listing.produce_type)
    expect(listing_info[:description]).to eq(listing.description)
    expect(listing_info[:quantity]).to eq(listing.quantity)
    expect(listing_info[:unit]).to eq(listing.unit)
    expect(listing_info[:dateHarvested].to_datetime).to eq(listing.date_harvested)
    expect(listing_info[:createdAt].to_datetime).to be_a(DateTime)
  end

  it 'cannot create a listing when missing user_id' do 
    user = create(:user)
    listing = create(:listing)
    query_string = <<-GRAPHQL
     mutation {
       createListing(input: {
        zipCode: "#{listing.zip_code}", 
        produceName: "#{listing.produce_name}", 
        produceType: "#{listing.produce_type}", 
        description: "#{listing.description}", 
        quantity: #{listing.quantity}, 
        unit: "#{listing.unit}",
        dateHarvested: "#{listing.date_harvested}"}) {
          listing {
            zipCode
          }
          error
        }
      }
    GRAPHQL
    
    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    error = result[:data][:createListing][:error]

    expect(error[0]).to eq('User must exist')
  end

  it 'can return a user object type' do 
    user = create(:user)
    listing = create(:listing)
    
    query_string = <<-GRAPHQL
     mutation {
       createListing(input: {
        userId: #{user.id}, 
        zipCode: "#{listing.zip_code}", 
        produceName: "#{listing.produce_name}", 
        produceType: "#{listing.produce_type}", 
        description: "#{listing.description}", 
        quantity: #{listing.quantity}, 
        unit: "#{listing.unit}",
        dateHarvested: "#{listing.date_harvested}"}) {
          listing {
            user {
              firstName
              lastName
              email
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    user_info = result[:data][:createListing][:listing][:user]

    expect(user_info[:firstName]).to eq(user.first_name)
    expect(user_info[:lastName]).to eq(user.last_name)
    expect(user_info[:email]).to eq(user.email)
  end

end
