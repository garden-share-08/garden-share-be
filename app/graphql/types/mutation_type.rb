module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_listing, mutation: Mutations::CreateListing
    field :update_listing, mutation: Mutations::UpdateListing
    field :create_offer, mutation: Mutations::CreateOffer
    field :delete_listing, mutation: Mutations::DeleteListing
    field :accept_offer, mutation: Mutations::AcceptOffer
    field :decline_offer, mutation: Mutations::DeclineOffer
    field :delete_offer, mutation: Mutations::DeleteOffer
  end
end
