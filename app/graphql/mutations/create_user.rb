module Mutations 
  class CreateUser < Mutations::BaseMutation 
    description "Create a user record"
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    
    field :user, Types::UserType, null: true
    field :message, [String], null: false
    field :error, [String], null: false
    
    def resolve(args)
      error = []
      message = []
      new_user = User.new(args)
      if new_user.save 
        {
          user: new_user,
          message: ["User created"],
          error: error
        }
      else 
          user = User.find_by(email: args[:email])
          message = ["User already exists"] if user
          error = new_user.errors.full_messages if user.nil?
        {
          user: user,
          message: message,
          error: error
        }
      end
    end

  end
end
