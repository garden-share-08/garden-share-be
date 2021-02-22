module Types
  class ListingType < Types::BaseObject
    field :id, Integer, null: false 
    field :user, Types::UserType, null: false
    field :offers, [Types::OfferType], null: true
    field :zip_code, String, null: false
    field :produce_name, String, null: false
    field :produce_type, String, null: false
    field :description, String, null: true
    field :quantity, Integer, null: false
    field :unit, String, null: false
    field :date_harvested, String, null: false
    field :status, String, null: false
    field :created_at, String, null: false
    field :updated_at, String, null: false
  end
end
