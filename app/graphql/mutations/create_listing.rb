module Mutations
  class CreateListing < Mutations::BaseMutation
    description "Create a listing record"
    argument :user_id, Integer, required: true
    argument :zip_code, String, required: true
    argument :produce_name, String, required: true
    argument :produce_type, String, required: true
    argument :description, String, required: false
    argument :quantity, Float, required: false
    argument :unit, String, required: true
    argument :date_harvested, GraphQL::Types::ISO8601DateTime, required: false

    field :listing, Types::ListingType, null: true
    field :error, [String], null: false

    def resolve(args)
      require "pry"; binding.pry
      # new_listing = Listing.new(args)
      # if new_listing.save
      #   {
      #     listing: new_listing,
      #     error: []
      #   }
      # else
      #   {
      #     listing: new_listing,
      #     error: new_listing.errors.full_messages
      #   }
      # end
    end
  end
end
