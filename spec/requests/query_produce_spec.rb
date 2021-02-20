require 'rails_helper'

describe 'Produce Query' do
  before :each do
    @produce1 = Produce.create(name: "Capers", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    @produce2 = Produce.create(name: "French eschallots", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
    @produce3 = Produce.create(name: "Lettuce", image: "https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg")
  end

  it 'returns all produce' do
    query_string = <<-GRAPHQL
    {
      fetchAllProduce {
        name,
        image
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body)
    expect(result).to eq({
                           'data' => {
                             'fetchAllProduce' => [{
                               'name' => "Capers",
                               'image' => 'https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg'
                             },
                              {
                                'name' => "French eschallots",
                                'image' => 'https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg'
                              },
                              {
                                'name' => "Lettuce",
                                'image' => 'https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg'
                              }]
                           }
                         })
  end

  it "can fetch produce by name" do
    produce_name = @produce1.name
    query_string = <<-GRAPHQL
    {
      fetchProduceByName(name:"#{produce_name}") {
        name,
        image
      }
    }
    GRAPHQL

    post graphql_path, params: { query: query_string }
    result = JSON.parse(response.body)
    expect(result).to eq({
                           'data' => {
                             'fetchProduceByName' => [{
                               'name' => "Capers",
                               'image' => 'https://cdn.britannica.com/17/196817-050-6A15DAC3/vegetables.jpg'
                             }]
                           }
                         })
  end
end
