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
    expect(first_apple[:quantity]).to be_a(Integer)
    expect(first_apple[:unit]).to be_a(String)
    expect(first_apple[:zip_code]).to be_a(String)

    expect(first_pepper[:produce_name]).to eq('peppers')
    expect(first_pepper[:produce_type]).to be_a(String)
    expect(first_pepper[:quantity]).to be_a(Integer)
    expect(first_pepper[:unit]).to be_a(String)
    expect(first_pepper[:zip_code]).to be_a(String)
  end

  it 'that have been posted for no longer than 72 hours' do 
    apples_1, apples_2 = create_list(:listing, 2, produce_name: 'apples', date_harvested: (DateTime.now - 4.days))
    peppers_1, peppers_2, peppers_3 = create_list(:listing, 3, produce_name: 'peppers', date_harvested: DateTime.now)

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
    apples_1, apples_2 = create_list(:listing, 2, produce_name: 'apples', date_harvested: (DateTime.now - 4.days))

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
end
