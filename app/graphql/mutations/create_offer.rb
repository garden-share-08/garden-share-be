module Mutations
  class CreateOffer < Mutations::BaseMutation
    description "Create a offer record"

    argument :user_id, Integer, required: false
    argument :listing_id, Integer, required: false
    argument :produce_name, String, required: false
    argument :produce_type, String, required: false
    argument :description, String, required: false
    argument :quantity, Integer, required: false
    argument :unit, String, required: false
    argument :date_harvested, String, required: false

    field :offer, Types::OfferType, null: true
    field :error, [String], null: false

    def resolve(args)
      # new_offer = Offer.new(args)
      # if new_offer.save
      #   {
      #     offer: new_offer,
      #     error: []
      #   }
      # else
      #   {
      #     offer: new_offer,
      #     error: new_offer.errors.full_messages
      #   }
      # end
    end
  end
end
