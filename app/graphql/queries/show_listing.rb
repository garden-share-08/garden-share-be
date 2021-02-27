module Queries 
  class ShowListing < Queries::BaseQuery
    description "Show a posted listing" 

    argument :id, Integer, required: null 

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
