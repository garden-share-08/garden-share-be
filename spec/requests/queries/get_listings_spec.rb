require 'rails_helper'

RSpec.describe 'backend can return all listings' do 
  it 'alphabetized and grouped' do 
    peppers_1, peppers_2, peppers_3 = create_list(:listing, 3, produce_name: 'peppers', date_harvested: DateTime.now)
    apples_1, apples_2 = create_list(:listing, 2, produce_name: 'apples', date_harvested: DateTime.now)

    query_string = <<-GRAPHQL
      query {
        getListings {
          listings
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    all_produce = result[:data][:getListings][:listings]
    first_apple = all_produce[:apples][0]
    first_pepper = all_produce[:peppers][0]

    expect(result[:data][:getListings][:error]).to be_empty

    expect(all_produce[:apples].count).to eq(2)
    expect(all_produce[:peppers].count).to eq(3)
    
    expect(first_apple[:produce_name]).to eq('apples')
    expect(first_apple[:produce_type]).to be_a(String)
    expect(first_apple[:description]).to be_a(String)
    expect(first_apple[:date_harvested]).to be_a(String)
    expect(first_apple[:status]).to be_a(String)
    expect(first_apple[:quantity]).to be_a(Integer)
    expect(first_apple[:unit]).to be_a(String)
    expect(first_apple[:zip_code]).to be_a(String)
    expect(first_apple[:created_at]).to be_a(String)
    expect(first_apple[:updated_at]).to be_a(String)

    expect(first_pepper[:produce_name]).to eq('peppers')
    expect(first_apple[:produce_type]).to be_a(String)
    expect(first_apple[:description]).to be_a(String)
    expect(first_apple[:date_harvested]).to be_a(String)
    expect(first_apple[:status]).to be_a(String)
    expect(first_apple[:quantity]).to be_a(Integer)
    expect(first_apple[:unit]).to be_a(String)
    expect(first_apple[:zip_code]).to be_a(String)
    expect(first_apple[:created_at]).to be_a(String)
    expect(first_apple[:updated_at]).to be_a(String)
  end

  it 'that have been posted for no longer than 72 hours' do 
    apples_1, apples_2 = create_list(:listing, 2, produce_name: 'apples', updated_at: (DateTime.now - 4.days))
    peppers_1, peppers_2, peppers_3 = create_list(:listing, 3, produce_name: 'peppers', updated_at: DateTime.now)

    query_string = <<-GRAPHQL
      query {
        getListings {
          listings
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)
    all_produce = result[:data][:getListings][:listings]
    first_pepper = all_produce[:peppers][0]
  
    expect(result[:data][:getListings][:error]).to be_empty

    expect(all_produce[:apples]).to be_nil
    expect(all_produce[:peppers].count).to eq(3)
  end

  it 'returns nil when there are no recent listings' do 
    apples_1, apples_2 = create_list(:listing, 2, produce_name: 'apples', updated_at: (DateTime.now - 4.days))

    query_string = <<-GRAPHQL
      query {
        getListings {
          listings
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data][:getListings][:listings]).to be_empty
    expect(result[:data][:getListings][:error][0]).to eq('There are no recent produce listings')
  end

  it 'filtered by their zip code and radius' do 
    zip_code = "80017"
    zip_codes = File.read('spec/fixtures/get_zip_codes.json')
    radius = 5
    
    show_listing1 = create(:listing, zip_code: "80015", date_harvested: DateTime.now(), produce_name: 'Apples')
    show_listing2 = create(:listing, zip_code: "80041", date_harvested: DateTime.now(), produce_name: 'Bananas')
    show_listing3 = create(:listing, zip_code: "80013", date_harvested: DateTime.now(), produce_name: 'Carrots')
    no_show_listing1 = create(:listing, zip_code: "80219", date_harvested: DateTime.now(), produce_name: 'Dates')
    no_show_listing2 = create(:listing, zip_code: "45505", date_harvested: DateTime.now(), produce_name: 'Grapes')

    stub_request(:get, "https://gardeen-location-microservice.herokuapp.com/zipcodes/#{zip_code}/#{radius}")
        .to_return(status: 200, body: zip_codes, headers: {})

    query_string = <<-GRAPHQL
      query {
        getListings(zipCode: "#{zip_code}", radius: #{radius}) {
          listings
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    
    result = JSON.parse(response.body, symbolize_names: true)
    listings = result[:data][:getListings][:listings]

    expect(listings.count).to eq(3)
    
    expect(listings[:Apples][0][:id]).to eq(show_listing1.id)
    expect(listings[:Bananas][0][:id]).to eq(show_listing2.id)
    expect(listings[:Carrots][0][:id]).to eq(show_listing3.id)
    
    expect(listings[:Dates]).to be_nil
    expect(listings[:Grapes]).to be_nil
  end
end
