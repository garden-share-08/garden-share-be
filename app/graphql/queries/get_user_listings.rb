module Queries 
  class GetUserListings < Queries::BaseQuery
    description 'Return all user listings and their offers'

    argument :id, Integer, required: true 

    field :listings, [Types::ListingType], null: true
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        listings = Listing.where('user_id = ?', args[:id])
                          .includes(offers: :user)
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
