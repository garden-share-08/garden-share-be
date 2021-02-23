require 'rails_helper'

RSpec.describe 'backend acceptOffer mutation request' do
  it "updates a listing status to accept" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
    mutation {
      acceptOffer(input: {
        id: #{offer.id}}) {
        listing {
          id
          status
          offers {
            id
            status
          }
        }
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    updated_listing = result[:data][:acceptOffer][:listing]
    updated_offer = updated_listing[:offers][0]

    expect(updated_offer[:id]).to eq(offer.id)
    expect(updated_offer[:status]).to eq("accepted")

    expect(updated_listing[:status]).to eq("accepted")
    expect(updated_listing[:id]).to eq(listing.id)
  end
end
