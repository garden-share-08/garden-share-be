module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :get_all_produce, resolver: Queries::GetAllProduce
    field :get_produce_by_name, resolver: Queries::GetProduceByName
    field :show_listing, resolver: Queries::ShowListing
    field :get_listings, resolver: Queries::GetListings
    field :get_user_listings, resolver: Queries::GetUserListings
  end
end
