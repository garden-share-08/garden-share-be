require 'rails_helper'

RSpec.describe 'backend can respond with a user\'s offers and associated listings' do 
  it 'with a valid offer id' do 
    user = create(:user)
    listing_1 = create(:listing_with_offers, offer_count: 1, offer_user: user)
    listing_2 = create(:listing_with_offers, offer_count: 1, offer_user: user)
    listing_3 = create(:listing_with_offers, offer_count: 1, offer_user: user)

    other_offer = create(:offer, listing: listing_1)
    other_listing = create(:listing_with_offers, offer_count: 4)
    
    offer_1 = listing_1.offers[0]
    offer_2 = listing_2.offers[0]
    offer_3 = listing_3.offers[0]

    query_string = <<-GRAPHQL
      {
        getUserOffers(id: #{user.id}) {
          listings {
            id 
            produceName 
            produceType
            quantity
            unit
            dateHarvested
            updatedAt
            user {
              id 
              firstName
            }
            offers {
              id
              produceName
              produceType
              quantity
              unit 
              dateHarvested
              updatedAt
              user {
                id
                firstName
              }
            }
          }
        }

      }
    GRAPHQL

    
    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)
    require 'pry'; binding.pry
    listings = result[:data][:getUserOffers]

    result_listing_1 = listings[2]
    result_listing_2 = listings[1]
    result_listing_3 = listings[0]

    # offers from most recent to oldest 
    result_offer_1 = listings[2][:offers]
    result_offer_2 = listings[1][:offers]
    result_offer_3 = listings[0][:offers]

    expect(listings).to be_a(Array)
    expect(listings.count).to eq(3)
    expect(offer_1).to be_a(Hash)

    # Check shape of listing data 
    expect(result_listing_1[:produceName]).to be_a(String)
    expect(result_listing_1[:produceType]).to be_a(String)
    expect(result_listing_1[:quantity]).to be_a(String)
    expect(result_listing_1[:unit]).to be_a(String)
    expect(result_listing_1[:dateHarvested]).to be_a(String)
    expect(result_listing_1[:updatedAt]).to be_a(String)
    expect(result_listing_1[:user]).to be_a(Hash)
    expect(result_listing_1[:user][:id]).to be_a(Integer)
    expect(result_listing_1[:user][:firstName]).to be_a(String)
    
    # Check shape of offer data 
    expect(result_offer_1[:produceName]).to be_a(String)
    expect(result_offer_1[:produceType]).to be_a(String)
    expect(result_offer_1[:quantity]).to be_a(String)
    expect(result_offer_1[:unit]).to be_a(String)
    expect(result_offer_1[:dateHarvested]).to be_a(String)
    expect(result_offer_1[:updatedAt]).to be_a(String)
    expect(result_offer_1[:user]).to be_a(Hash)

    # Check that offers belong to user
    expect(offer_1[:user][:id]).to eq(user.id)
    expect(offer_1[:user][:email]).to eq(user.firstName)
    expect(offer_2[:user][:id]).to eq(user.id)
    expect(offer_2[:user][:email]).to eq(user.firstName)
    expect(offer_3[:user][:id]).to eq(user.id)
    expect(offer_3[:user][:email]).to eq(user.firstName)
  end

  it 'unless offer id is invalid' do 

  end
end
