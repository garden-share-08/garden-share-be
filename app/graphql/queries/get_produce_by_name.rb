module Queries
  class GetProduceByName < Queries::BaseQuery
    argument :name, String, required: true
    field :produce, Types::ProduceType, null: false
    field :error, [String], null: false


     def resolve(args)
      produce = Produce.find_by(name: args[:name])
      {
        produce: produce,
        error: []
      }
     end
  end
end
