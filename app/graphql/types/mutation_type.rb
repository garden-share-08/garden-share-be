module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_listing, mutation: Mutations::CreateListing
    field :create_offer, mutation: Mutations::CreateOffer
  end
end
