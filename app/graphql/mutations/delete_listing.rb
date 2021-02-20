module Mutations 
  class DeleteListing < Mutations::BaseMutation
    description "Delete an existing listing" 

    argument :id, Integer, required: true 

    field :listing, Types::ListingType, null: true 
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        deleted_listing = Listing.destroy(args[:id])
      rescue 
        error << "Couldn't find Listing with 'id'=#{args[:id]}"
      end
      {
        listing: deleted_listing, 
        error: error
      }
    end
  end
end
