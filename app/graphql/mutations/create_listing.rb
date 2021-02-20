module Mutations
  class CreateListing < Mutations::BaseMutation
    description "Create a listing record"
    
    argument :user_id, Integer, required: false
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
      new_listing = Listing.new(args)
      if new_listing.save
        {
          listing: new_listing,
          error: []
        }
      else
        {
          listing: new_listing,
          error: new_listing.errors.full_messages
        }
      end
    end
  end
end
