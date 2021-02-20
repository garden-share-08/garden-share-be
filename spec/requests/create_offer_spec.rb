require 'rails_helper'

RSpec.describe 'backend createOffer mutation request' do
  it 'creates a offer' do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        userId: #{buyer.id},
        listingId: #{listing.id},
        produceName: "#{offer.produce_name}",
        produceType: "#{offer.produce_type}",
        description: "#{offer.description}",
        quantity: #{offer.quantity},
        unit: "#{offer.unit}",
        dateHarvested: "#{offer.date_harvested}"}) {
          offer {
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    offer_info = result[:data][:createOffer][:offer]
    error = result[:data][:createOffer][:error]

    expect(error).to be_empty
    expect(offer_info[:produceName]).to eq(offer.produce_name)
    expect(offer_info[:produceType]).to eq(offer.produce_type)
    expect(offer_info[:description]).to eq(offer.description)
    expect(offer_info[:quantity]).to eq(offer.quantity)
    expect(offer_info[:unit]).to eq(offer.unit)
    expect(offer_info[:dateHarvested].to_datetime).to eq(offer.date_harvested)
    expect(offer_info[:createdAt].to_datetime).to be_a(DateTime)
  end

  it "cannot create an offer when missing a user_id" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        listingId: #{listing.id},
        produceName: "#{offer.produce_name}",
        produceType: "#{offer.produce_type}",
        description: "#{offer.description}",
        quantity: #{offer.quantity},
        unit: "#{offer.unit}",
        dateHarvested: "#{offer.date_harvested}"}) {
          offer {
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    error = result[:data][:createOffer][:error]

    expect(error[0]).to eq('User must exist')
  end

  it "cannot create an offer when missing a listing_id" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        userId: #{buyer.id},
        produceName: "#{offer.produce_name}",
        produceType: "#{offer.produce_type}",
        description: "#{offer.description}",
        quantity: #{offer.quantity},
        unit: "#{offer.unit}",
        dateHarvested: "#{offer.date_harvested}"}) {
          offer {
            produceName
            produceType
            description
            quantity
            unit
            dateHarvested
            createdAt
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    error = result[:data][:createOffer][:error]

    expect(error[0]).to eq('Listing must exist')
  end

  it "can return a user object type" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        userId: #{buyer.id},
        listingId: #{listing.id},
        produceName: "#{offer.produce_name}",
        produceType: "#{offer.produce_type}",
        description: "#{offer.description}",
        quantity: #{offer.quantity},
        unit: "#{offer.unit}",
        dateHarvested: "#{offer.date_harvested}"}) {
          offer {
            user {
              firstName
              lastName
              email
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    user_info = result[:data][:createOffer][:offer][:user]

    expect(user_info[:firstName]).to eq(buyer.first_name)
    expect(user_info[:lastName]).to eq(buyer.last_name)
    expect(user_info[:email]).to eq(buyer.email)
  end

  it "can return a listing object type" do
    seller = create(:user)
    listing = create(:listing, user_id: seller.id)
    buyer = create(:user)
    offer = create(:offer, user_id: buyer.id, listing_id: listing.id)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        userId: #{buyer.id},
        listingId: #{listing.id},
        produceName: "#{offer.produce_name}",
        produceType: "#{offer.produce_type}",
        description: "#{offer.description}",
        quantity: #{offer.quantity},
        unit: "#{offer.unit}",
        dateHarvested: "#{offer.date_harvested}"}) {
          offer {
            listing {
              zipCode
              produceName
              produceType
              description
              quantity
              unit
              dateHarvested
              createdAt
            }
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    listing_info = result[:data][:createOffer][:offer][:listing]

    expect(listing_info[:zipCode]).to eq(listing.zip_code)
    expect(listing_info[:produceName]).to eq(listing.produce_name)
    expect(listing_info[:produceType]).to eq(listing.produce_type)
    expect(listing_info[:description]).to eq(listing.description)
    expect(listing_info[:quantity]).to eq(listing.quantity)
    expect(listing_info[:unit]).to eq(listing.unit)
    expect(listing_info[:dateHarvested].to_datetime).to eq(listing.date_harvested)
    expect(listing_info[:createdAt].to_datetime).to be_a(DateTime)
  end
end
