module Queries
  class GetAllProduce < Queries::BaseQuery
     field :produce, [Types::ProduceType], null: false
     field :error, [String], null: false

     def resolve
      produce = Produce.all
      {
        produce: produce,
        error: []
      }
     end
  end
end
