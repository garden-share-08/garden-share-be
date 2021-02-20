require 'rails_helper'

RSpec.describe 'backend createOffer mutation request' do
  it 'creates a offer' do
    user = create(:user)
    listing = create(:listing)
    offer = create(:offer)
    query_string = <<-GRAPHQL
     mutation {
       createOffer(input: {
        userId: #{user.id},
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
  end
end
