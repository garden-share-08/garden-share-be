module Mutations
  class AcceptOffer < Mutations::BaseMutation
    description "Change status of existing offer to accept"

    argument :id, Integer, required: true

    field :listing, Types::ListingType, null: true
    field :error, [String], null: false

    def resolve(args)
      error = []
      begin
        accepted_offer = Offer.find(args[:id])
        accepted_offer.update_attributes(status: "accepted")
        accepted_offer.listing.update_attributes(status: "accepted")
        listing = accepted_offer.listing
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
