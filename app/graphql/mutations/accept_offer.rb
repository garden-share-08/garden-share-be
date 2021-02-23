module Mutations
  class AcceptOffer < Mutations::BaseMutation
    description "Change status of existing offer to accept"

    argument :id, Integer, required: true
    argument :status, String, required: true
    # argument :zip_code, String, required: false
    # argument :produce_name, String, required: false
    # argument :produce_type, String, required: false
    # argument :description, String, required: false
    # argument :quantity, Integer, required: false
    # argument :unit, String, required: false
    # argument :date_harvested, String, required: false

    field :offer, Types::OfferType, null: true
    field :listing, Types::ListingType, null: true
    field :error, [String], null: false

    def resolve(args)
      require "pry"; binding.pry
    #   error = []
    #   begin
    #
    #   rescue
    #
    #   end
    #
    #   {
    #     
    #     error: error
    #   }
    end
  end
end
