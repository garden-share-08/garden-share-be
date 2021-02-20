module Queries 
  class ShowListing < Queries::BaseQuery
    description "Show a posted listing" 

    argument :id, Integer, required: true 

    field :error, [String], null: false 
    field :listing, Types::ListingType, null: true 

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
