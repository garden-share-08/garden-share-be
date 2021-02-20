module Mutations 
  class UpdateListing < Mutations::BaseMutation 
    description "Update a pre-existing listing" 

    argument :id, Integer, required: true 
    argument :zip_code, String, required: false
    argument :produce_name, String, required: false
    argument :produce_type, String, required: false
    argument :description, String, required: false
    argument :quantity, Integer, required: false
    argument :unit, String, required: false
    argument :date_harvested, String, required: false

    field :listing, Types::ListingType, null: true 
    field :error, [String], null: false 

    def resolve(args)
      error = []
      begin
        updated_listing = Listing.update(args[:id], args)
      rescue
        error << "Couldn't find Listing with 'id'=#{args[:id]}"
      end

      {
        listing: updated_listing,
        error: error
      }
    end
  end
end
