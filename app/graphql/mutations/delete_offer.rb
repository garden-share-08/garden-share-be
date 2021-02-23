module Mutations 
  class DeleteOffer < Mutations::BaseMutation
    description 'deletes an offer' 

    argument :id, Integer, required: true 

    field :offer, Types::OfferType, null: true 
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        offer = Offer.destroy(args[:id])
      rescue 
        error << "Couldn't find Offer with 'id'=#{args[:id]}"
      end
      {
        offer: offer, 
        error: error
      }
    end
  end
end
