module Mutations
  class DeclineOffer < Mutations::BaseMutation
    description "Change status of existing offer to declined"

    argument :id, Integer, required: true

    field :listing, Types::ListingType, null: true
    field :error, [String], null: false

    def resolve(args)
      error = []
      begin
        declined_offer = Offer.find(args[:id])
        declined_offer.update_attributes(status: "declined")
        listing = declined_offer.listing
      rescue
        error << "Couldn't find Offer with 'id'=#{args[:id]}"
      end
      {
        listing: listing,
        error: error
      }
    end
  end
end
