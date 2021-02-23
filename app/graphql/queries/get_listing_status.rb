module Queries 
  class GetListingStatus < Queries::BaseQuery
    description 'returns status for a listing' 

    argument :id, Integer, required: true

    field :listing, Types::ListingType, null: true 
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        listing = Listing.find(args[:id])
      rescue
        error << "Couldn't find Listing with 'id'=#{args[:id]}"
      end
      {
        listing: listing, 
        error: error
      }
    end
  end
end
