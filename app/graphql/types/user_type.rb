module Types 
  class UserType < Types::BaseObject 
    field :id, Integer, null: false
    field :first_name, String, null: false 
    field :last_name, String, null: false 
    field :email, String, null: false
  end
end
