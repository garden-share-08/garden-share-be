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
          error
        }

      }
    GRAPHQL

    
    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)

    listings = result[:data][:getUserOffers][:listings]
    error = result[:data][:getUserOffers][:error]

    result_listing_1 = listings[2]
    result_listing_2 = listings[1]
    result_listing_3 = listings[0]

    # offers from most recent to oldest 
    result_offer_1 = listings[2][:offers][0]
    result_offer_2 = listings[1][:offers][0]
    result_offer_3 = listings[0][:offers][0]

    expect(error).to be_empty
    expect(listings).to be_a(Array)
    expect(listings.count).to eq(3)
    expect(result_offer_1).to be_a(Hash)

    # Check shape of listing data 
    expect(result_listing_1[:produceName]).to be_a(String)
    expect(result_listing_1[:produceType]).to be_a(String)
    expect(result_listing_1[:quantity]).to be_a(Integer)
    expect(result_listing_1[:unit]).to be_a(String)
    expect(result_listing_1[:dateHarvested]).to be_a(String)
    expect(result_listing_1[:updatedAt]).to be_a(String)
    expect(result_listing_1[:user]).to be_a(Hash)
    expect(result_listing_1[:user][:id]).to be_a(Integer)
    expect(result_listing_1[:user][:firstName]).to be_a(String)
    
    # Check shape of offer data 
    expect(result_offer_1[:produceName]).to be_a(String)
    expect(result_offer_1[:produceType]).to be_a(String)
    expect(result_offer_1[:quantity]).to be_a(Integer)
    expect(result_offer_1[:unit]).to be_a(String)
    expect(result_offer_1[:dateHarvested]).to be_a(String)
    expect(result_offer_1[:updatedAt]).to be_a(String)
    expect(result_offer_1[:user]).to be_a(Hash)

    # Check that offers belong to user
    expect(result_offer_1[:user][:id]).to eq(user.id)
    expect(result_offer_1[:user][:firstName]).to eq(user.first_name)
    expect(result_offer_2[:user][:id]).to eq(user.id)
    expect(result_offer_2[:user][:firstName]).to eq(user.first_name)
    expect(result_offer_3[:user][:id]).to eq(user.id)
    expect(result_offer_3[:user][:firstName]).to eq(user.first_name)
  end

  it 'unless user does not have any offers' do
    user = create(:user)
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
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)

    listings = result[:data][:getUserOffers][:listings]
    error = result[:data][:getUserOffers][:error][0]
    
    expect(listings).to be_empty 
    expect(error).to eq("Couldn't find any Offers for User with 'id'=#{user.id}")
  end

  it 'unless user id is invalid' do 
    user = create(:user)
    listing = create(:listing_with_offers, offer_count: 1, offer_user: user)
    non_id = user.id + 1
      
    query_string = <<-GRAPHQL
    {
      getUserOffers(id: #{non_id}) {
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
        error
      }
    }
  GRAPHQL

  post graphql_path, params: { query: query_string }
  
  result = JSON.parse(response.body, symbolize_names: true)

  listings = result[:data][:getUserOffers][:listings]
  error = result[:data][:getUserOffers][:error][0]
  
  expect(listings).to be_empty 
  expect(error).to eq("Couldn't find any Offers for User with 'id'=#{non_id}")
  end

  it 'returns offers from most recent to oldest' do 
    user = create(:user)
    listing_1 = create(:listing)
    listing_2 = create(:listing)
    listing_3 = create(:listing)
    older_offer = create(:offer, user: user, listing: listing_1, created_at: (DateTime.now - 1.days), updated_at: (DateTime.now - 1.days))
    newer_offer = create(:offer, user: user, listing: listing_2)
    oldest_offer = create(:offer, user: user, listing: listing_3, created_at: (DateTime.now - 2.days), updated_at: (DateTime.now - 2.days))

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
        error
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    listings = result[:data][:getUserOffers][:listings]
    error = result[:data][:getUserOffers][:error]

    result_offer_1 = listings[0][:offers][0]
    result_offer_2 = listings[1][:offers][0]
    result_offer_3 = listings[2][:offers][0]

    expect(error).to be_empty
    expect(result_offer_1[:id]).to eq(newer_offer.id)
    expect(result_offer_2[:id]).to eq(older_offer.id)
    expect(result_offer_3[:id]).to eq(oldest_offer.id)
  end
end
