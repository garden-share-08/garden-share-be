module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    extend GraphQL::Schema::Member::HasFields
    extend GraphQL::Schema::Resolver::HasPayloadType
  end
end
