module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :fetch_all_produce, resolver: Queries::FetchAllProduce
    field :fetch_produce_by_name, resolver: Queries::FetchProduceByName
  end
end
