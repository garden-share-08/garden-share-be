module Queries
  class FetchAllProduce < Queries::BaseQuery
     type [Types::ProduceType], null: false

     def resolve
      Produce.all
     end
  end
end
