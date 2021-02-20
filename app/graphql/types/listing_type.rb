module Types
  class ListingType < Types::BaseObject
    field :zip_code, String, null: false
    field :produce_name, String, null: false
    field :produce_type, String, null: false
    field :description, String, null: true
    field :quantity, Float, null: true
    field :unit, String, null: false
    field :date_harvested, GraphQL::Types::ISO8601DateTime, null: false
    field :status, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
