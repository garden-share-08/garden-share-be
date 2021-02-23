require 'rails_helper'

RSpec.describe 'backend can return the status of a listing' do 
  it 'with a valid listing id' do 
    # For listing with a 'pending' status
    pending_listing = create(:listing, status: 'pending')
    query_string = <<-GRAPHQL
    query {
      getListingStatus(id: #{pending_listing.id}) {
        listing {
          id 
          status
        }
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    listing = result[:data][:getListingStatus][:listing]
    error = result[:data][:getListingStatus][:error]
    
    expect(error).to be_empty
    expect(listing[:id]).to be_a(Integer)
    expect(listing[:status]).to be_a(String)
    expect(listing[:status]).to eq(pending_listing.status)

    # For a listing with an 'accepted' status
    accepted_listing = create(:listing, status: 'accepted')
    query_string = <<-GRAPHQL
    query {
      getListingStatus(id: #{accepted_listing.id}) {
        listing {
          id 
          status
        }
        error
      }
    }
    GRAPHQL
    
    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    listing = result[:data][:getListingStatus][:listing]
    error = result[:data][:getListingStatus][:error]
    
    expect(error).to be_empty
    expect(listing[:id]).to be_a(Integer)
    expect(listing[:status]).to be_a(String)
    expect(listing[:status]).to eq(accepted_listing.status)
  end

  it 'returns error with invalid listing id' do 
    listing = create(:listing)
    non_id = listing.id + 1
    query_string = <<-GRAPHQL
    query {
      getListingStatus(id: #{non_id}) {
        listing {
          id 
          status
        }
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    result_listing = result[:data][:getListingStatus][:listing]
    error = result[:data][:getListingStatus][:error]

    expect(result_listing).to be_nil
    expect(error[0]).to eq("Couldn't find Listing with 'id'=#{non_id}")
  end
end
