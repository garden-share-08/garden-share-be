module Queries 
  class GetListings < Queries::BaseQuery
    description 'Get all grouped listings within 72 hours'

    field :listings, GraphQL::Types::JSON, null: true 
    field :error, [String], null: false 

    def resolve
      error = []
      three_days_ago = DateTime.now - 3.days
      listings = Listing.where('date_harvested >= ?', three_days_ago).order('produce_name').group_by(&:produce_name)
      error << 'There are no recent produce listings' if listings.empty?
      {
        listings: listings, 
        error: error
      }
    end
  end
end
