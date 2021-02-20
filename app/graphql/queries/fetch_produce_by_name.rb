module Queries
  class FetchProduceByName < Queries::BaseQuery
     type [Types::ProduceType], null: false
     argument :name, String, required: true

     def resolve(args)
      Produce.where(name: args[:name])
     end
  end
end
