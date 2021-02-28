module Queries 
  class GetListings < Queries::BaseQuery
    description 'Get all grouped listings within 72 hours'

    field :listings, GraphQL::Types::JSON, null: true 
    field :error, [String], null: false 

    argument :zip_code, String, required: false
    argument :radius, Integer, required: false

    def get_zip_codes(args)
      response = LocationService.get_zip_codes(args[:zip_code], args[:radius])
      return response[:zip_codes], response[:error_msg]
    end
    
    def resolve(args = nil)
      error = []
      three_days_ago = DateTime.now - 3.days
      zip_codes, error_msg = get_zip_codes(args) if args
      
      if args.nil?
        listings = Listing.where('updated_at >= ?', three_days_ago)
                          .order('produce_name')
                          .group_by(&:produce_name)

        error << 'There are no recent produce listings' if listings.empty?
      else 
        listings = Listing.where('updated_at >= ? AND zip_code IN (?)', three_days_ago, zip_codes)
                          .order('produce_name')
                          .group_by(&:produce_name)

        error << 'There are no recent produce listings' if listings.empty? && !error_msg
        error << error_msg if error_msg
      end
      {
        listings: listings, 
        error: error
      }
    end
  end
end
