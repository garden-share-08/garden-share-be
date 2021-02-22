require 'rails_helper'

RSpec.describe 'backend returns a user\'s listings and its offers' do 
  it 'with a user id' do 
    user = create(:user)
    listing_1, listing_2, listing_3 = create_list(:listing_with_offers, 2, user: user, offer_count: 3)
    other_user_listings = create_list(:listing_with_offers, 3)

    query_string = <<-GRAPHQL
      query {
        getUserListings(id: #{user.id}) {
          listings {
            user {
              firstName
            }
            produceName
            produceType
            description
            quantity 
            unit
            zipCode
            status
            updatedAt
            offers {
              user {
                firstName
                lastName
                email
              }
              produceName
              produceType
              description
              quantity
              unit
              status
              updatedAt
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    listings = result[:data][:getUserListings][:listings]
    error = result[:data][:getUserListings][:error]
    first_listing = listings[0]
    offers = first_listing[:offers]
    first_offer = offers[0]
    offer_user = first_offer[:user]

    expect(error).to be_empty
    
    expect(listings).to be_a(Array)
    expect(listings.count).to eq(2)
    expect(offers).to be_a(Array)
    expect(offers.count).to eq(3)
    
    expect(first_listing[:user][:firstName]).to eq(user.first_name)
    expect(first_listing[:produceName]).to be_a(String)
    expect(first_listing[:produceType]).to be_a(String)
    expect(first_listing[:description]).to be_a(String)
    expect(first_listing[:quantity]).to be_a(Integer)
    expect(first_listing[:unit]).to be_a(String)
    expect(first_listing[:zipCode]).to be_a(String)
    expect(first_listing[:status]).to be_a(String)
    expect(first_listing[:updatedAt]).to be_a(String)

    expect(first_offer[:produceName]).to be_a(String)
    expect(first_offer[:produceType]).to be_a(String)
    expect(first_offer[:description]).to be_a(String)
    expect(first_offer[:quantity]).to be_a(Integer)
    expect(first_offer[:unit]).to be_a(String)
    expect(first_offer[:status]).to be_a(String)
    expect(first_offer[:updatedAt]).to be_a(String)

    expect(offer_user[:firstName]).to be_a(String)
    expect(offer_user[:lastName]).to be_a(String)
    expect(offer_user[:email]).to be_a(String)
  end

  it 'unless the user id is invalid' do 
    user = create(:user)
    non_id = user.id + 1
    listing_1, listing_2, listing_3 = create_list(:listing_with_offers, 2, user: user, offer_count: 3)

    query_string = <<-GRAPHQL
      query {
        getUserListings(id: #{non_id}) {
          listings {
            produceName
            offers {
              user {
                firstName
              }
              produceName
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    listings = result[:data][:getUserListings][:listings]
    error = result[:data][:getUserListings][:error]

    expect(listings).to be_empty 
    expect(error[0]).to eq("Couldn't find Listings for User with 'id'=#{non_id}")
  end

  it 'returns [] and error if user has no listings' do 
    user = create(:user)
    non_user_listings = create_list(:listing_with_offers, 3)

    query_string = <<-GRAPHQL
      query {
        getUserListings(id: #{user.id}) {
          listings {
            produceName
            offers {
              user {
                firstName
              }
              produceName
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    listings = result[:data][:getUserListings][:listings]
    error = result[:data][:getUserListings][:error]

    expect(listings).to be_empty 
    expect(error[0]).to eq("Couldn't find Listings for User with 'id'=#{user.id}")
  end

  xit 'includes only offers with a pending or accepted status in the listing' do 
    # Not sure if we want this test yet, so holding off on it for now 
    
    user = create(:user)
    listing = create(:listing, user: user)
    pending_offer = create(:offer, status: 'pending', listing: listing)
    accepted_offer = create(:offer, status: 'accepted', listing: listing)
    declined_offer = create(:offer, status: 'declined', listing: listing)

    other_listing = create(:listing_with_offers, offer_count: 2)

    query_string = <<-GRAPHQL
      query {
        getUserListings(id: #{user.id}) {
          listings {
            offers {
              user {
                firstName
              }
              produceName
              produceType
              description
              quantity
              unit
              status
              updatedAt
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)

    offers = result[:data][:getUserListings][:listings][0][:offers]
    error = result[:data][:getUserListings][:error]

    expect(offers.count).to eq(2)
    expect(offers).to_not include(declined_offer)
  end
end
