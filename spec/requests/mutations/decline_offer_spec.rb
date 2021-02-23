require 'rails_helper'

RSpec.describe 'backend declineOffer mutation request' do
  it "updates a offer status to declined" do
    offer = create(:offer, status: "pending")
    query_string = <<-GRAPHQL
    mutation {
      declineOffer(input: {
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
    updated_listing = result[:data][:declineOffer][:listing]
    updated_offer = updated_listing[:offers][0]

    expect(updated_offer[:id]).to eq(offer.id)
    expect(updated_offer[:status]).to eq("declined")

    expect(updated_listing[:status]).to eq("pending")

    error = result[:data][:declineOffer][:error]
    expect(error).to be_empty
  end

  it "errors out with an invalid offer id" do
    offer = create(:offer, status: "pending")
    query_string = <<-GRAPHQL
    mutation {
      declineOffer(input: {
        id: #{offer.id + 1}}) {
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
    error = result[:data][:declineOffer][:error]
    expect(error[0]).to eq("Couldn't find Offer with 'id'=#{offer.id + 1}")
  end
end
