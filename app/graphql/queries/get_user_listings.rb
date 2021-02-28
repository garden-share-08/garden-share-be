module Queries 
  class GetUserListings < Queries::BaseQuery
    description 'Return all user listings and their offers'

    argument :id, Integer, required: true 

    field :listings, [Types::ListingType], null: true
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        listings = Listing.includes(offers: :user)
                          .where('listings.user_id = ?', args[:id])
                          .order('listings.updated_at DESC')

        error << "Couldn't find Listings for User with 'id'=#{args[:id]}" if listings.empty?
      rescue 
        error << 'Something went wrong when processing your request'
      end
      {
        listings: listings, 
        error: error
      }
    end
  end
end
