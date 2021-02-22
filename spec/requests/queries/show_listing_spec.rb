require 'rails_helper'

RSpec.describe 'backend can return info for a listing' do 
  it 'with listing id' do 
    listing = create(:listing) 

    query_string = <<-GRAPHQL
      query {
        showListing(id: #{listing.id}) {
          listing {
            user {
              firstName
            }
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            zipCode
            status
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    displayed_listing = result[:data][:showListing][:listing]
    error = result[:data][:showListing][:error]


    expect(error).to be_empty 
    
    expect(displayed_listing[:user][:firstName]).to eq(listing.user.first_name)
    expect(displayed_listing[:user][:firstName]).to be_a(String)

    expect(displayed_listing[:produceName]).to eq(listing.produce_name)
    expect(displayed_listing[:produceName]).to be_a(String)

    expect(displayed_listing[:produceType]).to eq(listing.produce_type)
    expect(displayed_listing[:produceType]).to be_a(String)

    expect(displayed_listing[:description]).to eq(listing.description)
    expect(displayed_listing[:description]).to be_a(String)

    expect(displayed_listing[:quantity]).to eq(listing.quantity)
    expect(displayed_listing[:quantity]).to be_a(Integer)

    expect(displayed_listing[:unit]).to eq(listing.unit)
    expect(displayed_listing[:unit]).to be_a(String)

    expect(displayed_listing[:dateHarvested].to_datetime).to eq(listing.date_harvested)
    expect(displayed_listing[:dateHarvested]).to be_a(String)

    expect(displayed_listing[:zipCode]).to eq(listing.zip_code)
    expect(displayed_listing[:zipCode]).to be_a(String)

    expect(displayed_listing[:status]).to eq(listing.status)
    expect(displayed_listing[:status]).to be_a(String)

    expect(displayed_listing[:createdAt].to_datetime).to be_a(DateTime)
    expect(displayed_listing[:createdAt]).to be_a(String)
  end

  it 'unless id is invalid' do 
    listing = create(:listing) 
    non_id = listing.id + 1

    query_string = <<-GRAPHQL
      query {
        showListing(id: #{non_id}) {
          listing {
            user {
              firstName
            }
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            zipCode
            status
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    displayed_listing = result[:data][:showListing][:listing]
    error = result[:data][:showListing][:error]

    expect(displayed_listing).to be_nil 
    expect(error[0]).to eq("Couldn't find Listing with 'id'=#{non_id}")
  end
end
