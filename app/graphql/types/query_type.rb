module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :show_listing, resolver: Queries::ShowListing
    field :get_listings, resolver: Queries::GetListings
    field :get_user_listings, resolver: Queries::GetUserListings
  end
end
