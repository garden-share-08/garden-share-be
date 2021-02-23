module Queries
  class GetUserOffers < Queries::BaseQuery
    description "Get all user offers nested within their listings"

    argument :id, Integer, required: true 

    field :listings, [Types::ListingType], null: true 
    field :error, [String], null: false 

    def resolve(args)
      error = []
      listings = Listing.includes(offers: :user)
                        .where(offers: {users: {id: args[:id]}})
                        .order("offers.updated_at DESC")
                        
      error << "Couldn't find any Offers for User with 'id'=#{args[:id]}" if listings.empty?
      {
        listings: listings, 
        error: error
      }
    end
  end
end
