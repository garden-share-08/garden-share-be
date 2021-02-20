module Mutations 
  class CreateUser < Mutations::BaseMutation 
    description "Create a user record"
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    
    field :user, Types::UserType, null: true
    field :error, [String], null: false
    
    def resolve(args)
      new_user = User.new(args)
      if new_user.save 
        {
          user: new_user,
          error: []
        }
      else 
        {
          user: new_user,
          error: new_user.errors.full_messages
        }
      end
    end

  end
end
