require 'rails_helper'

RSpec.describe 'backend can delete an offer' do 
  it 'with a valid offer id' do 
    offer = create(:offer)
    mutation_string = <<-GRAPHQL
      mutation {
        deleteOffer(input: {id: #{offer.id}}) {
          offer {
            id
          }
          error
        }
      }
    GRAPHQL

    expect(Offer.find_by(id: offer.id)).to eq(offer)
    
    post graphql_path, params: { query: mutation_string }

    result = JSON.parse(response.body, symbolize_names: true)
    deleted_offer = result[:data][:deleteOffer][:offer]
    error = result[:data][:deleteOffer][:error]

    expect(error).to be_empty
    expect(deleted_offer[:id]).to eq(offer.id)
    expect(Offer.find_by(id: offer.id)).to eq(nil)
  end

  it 'unless the offer id is invalid' do 
    offer = create(:offer)
    non_id = offer.id + 1
    mutation_string = <<-GRAPHQL
      mutation {
        deleteOffer(input: {id: #{non_id}}) {
          offer {
            id
          }
          error
        }
      }
    GRAPHQL

    expect(Offer.find_by(id: offer.id)).to eq(offer)
    
    post graphql_path, params: { query: mutation_string }

    result = JSON.parse(response.body, symbolize_names: true)
    deleted_offer = result[:data][:deleteOffer][:offer]
    error = result[:data][:deleteOffer][:error]
    
    expect(error[0]).to eq("Couldn't find Offer with 'id'=#{non_id}")
    expect(deleted_offer).to be_nil
    expect(Offer.find_by(id: offer.id)).to eq(offer)
  end
end
