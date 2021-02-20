require 'rails_helper'

RSpec.describe 'backend can delete a user\'s listing' do 
  it 'with listing id' do 
    listing = create(:listing)

    mutation_string = <<-GRAPHQL
      mutation {
        deleteListing(input: {
          id: #{listing.id}
        }) {
          listing {
            id
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: mutation_string }

    result = JSON.parse(response.body, symbolize_names: true)
    deleted_listing = result[:data][:deleteListing][:listing]
    error = result[:data][:deleteListing][:error]

    expect(error).to be_empty
    expect(deleted_listing[:id]).to eq(listing.id)
    expect(Listing.find_by(id: listing.id)).to eq(nil)
  end

  it 'with offers' do 
    listing = create(:listing_with_offers, offer_count: 4)

    mutation_string = <<-GRAPHQL
      mutation {
        deleteListing(input: {
          id: #{listing.id}
        }) {
          listing {
            id
          }
          error
        }
      }
    GRAPHQL

    offer = listing.offers[0]

    expect(Offer.find_by(id: offer.id)).to eq(listing.offers[0])

    post graphql_path, params: { query: mutation_string }

    result = JSON.parse(response.body, symbolize_names: true)
    deleted_listing = result[:data][:deleteListing][:listing]
    error = result[:data][:deleteListing][:error]

    expect(error).to be_empty
    expect(deleted_listing[:id]).to eq(listing.id)
    expect(Listing.find_by(id: listing.id)).to be_nil
    expect(Offer.find_by(id: offer.id)).to be_nil
  end

  it 'unless listing doesn\'t exist' do 
    listing = create(:listing)
    non_id = listing.id + 1

    mutation_string = <<-GRAPHQL
      mutation {
        deleteListing(input: {
          id: #{non_id}
        }) {
          listing {
            id
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: mutation_string }

    result = JSON.parse(response.body, symbolize_names: true)
    deleted_listing = result[:data][:deleteListing][:listing]
    error = result[:data][:deleteListing][:error]

    expect(error[0]).to eq("Couldn't find Listing with 'id'=#{non_id}")
  end


end
