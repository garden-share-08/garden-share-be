module Queries 
  class GetListings < Queries::BaseQuery
    description 'Get all grouped listings within 72 hours'

    field :listings, GraphQL::Types::JSON, null: true 
    field :error, [String], null: false 

    argument :zip_code, String, required: false
    argument :radius, Integer, required: false

    def resolve(args = nil)
      result = ListingsFacade.get_listings(args)
      {
        listings: result[:listings], 
        error: result[:error]
      }
    end
  end
end
