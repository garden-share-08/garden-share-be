class ListingsFacade
  
  class << self 
    def get_listings(args = nil)
      # Get zip codes if necessary
      location_result = get_zip_codes(args) if args 
      error = []
      
      # Get filtered listings 
      if location_result && !location_result[:error_msg]
        listings = Listing.get_listings(location_result[:zip_codes])
        error = ['There are no recent produce listings'] if listings.empty?
      elsif location_result && location_result[:error_msg]
        listings = []
        error = location_result[:error_msg]
      else 
        listings = Listing.get_listings()
        error = ['There are no recent produce listings'] if listings.empty?
      end

      return {
        listings: listings,
        error: error
      }
    end

    def get_zip_codes(args) 
      LocationService.get_zip_codes(args[:zip_code], args[:radius])
    end
  end
  
end
