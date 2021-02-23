require 'rails_helper'

RSpec.describe 'backend acceptOffer mutation request' do
  it "updates a listing status to accept" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
    mutation {
      acceptOffer(id: #{offer.id}){
        listing {
          id: #{listing.id},
          status: "accepted"
          offer {
            id: #{offer.id},
            status: "accepted"
          }
        }
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    require "pry"; binding.pry
    result = JSON.parse(response.body, symbolize_names: true)
  end
end
