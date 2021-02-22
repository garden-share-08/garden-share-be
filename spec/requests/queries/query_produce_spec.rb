require 'rails_helper'

describe 'Produce Query' do
  before :each do
    @produce1 = Produce.create(name: "Capers", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    @produce2 = Produce.create(name: "French eschallots", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    @produce3 = Produce.create(name: "Lettuce", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
  end

  it 'returns all produce' do
    query_string = <<-GRAPHQL
      query {
        fetchAllProduce {
          produce {
            name
            image
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)
    capers = result[:data][:fetchAllProduce][:produce][0]
    french_eschallots = result[:data][:fetchAllProduce][:produce][1]
    lettuce = result[:data][:fetchAllProduce][:produce][2]

    expect(capers[:name]).to eq("Capers")
    expect(french_eschallots[:name]).to eq("French eschallots")
    expect(lettuce[:name]).to eq("Lettuce")
    expect(capers[:image]).to eq("https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    expect(french_eschallots[:image]).to eq("https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    expect(lettuce[:image]).to eq("https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
  end

  it "can fetch produce by name" do
    produce_name = @produce1.name
    query_string = <<-GRAPHQL
      query {
        fetchProduceByName(name:"#{produce_name}") {
          produce{
            name
            image
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body, symbolize_names: true)

    capers = result[:data][:fetchProduceByName][:produce]

    expect(capers[:name]).to eq("Capers")
    expect(capers[:image]).to eq("https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")

  end
end
