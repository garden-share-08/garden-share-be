require 'rails_helper'

RSpec.describe 'backend createUser mutation request' do
  it 'creates a unique user' do
    user = build(:user)
    query_string = <<-GRAPHQL
     mutation {
       createUser(input: {firstName: "#{user.first_name}", lastName: "#{user.last_name}", email: "#{user.email}"}) {
          user {
            id
            firstName
            lastName
            email
          }
          message
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)[:data][:createUser]
    user_info = result[:user]
    error = result[:error]
    message = result[:message]

    expect(error).to be_empty
    expect(message[0]).to eq('User created')

    expect(user_info[:id]).to be_a(Integer)
    expect(user_info[:firstName]).to eq(user.first_name)
    expect(user_info[:lastName]).to eq(user.last_name)
    expect(user_info[:email]).to eq(user.email)
  end

  it 'does not create a user that already exists, but returns their info' do
    user = create(:user)

    query_string = <<-GRAPHQL
     mutation {
       createUser(input: {firstName: "#{user.first_name}", lastName: "#{user.last_name}", email: "#{user.email}"}) {
          user {
            id
            firstName
            lastName
            email
          }
          message
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string}

    result = JSON.parse(response.body, symbolize_names: true)[:data][:createUser]
    result_user = result[:user]
    error = result[:error]
    message = result[:message]

    expect(result_user[:id]).to be_a(Integer)
    expect(result_user[:id]).to eq(user.id)

    expect(result_user[:firstName]).to be_a(String)
    expect(result_user[:firstName]).to eq(user.first_name)
    
    expect(result_user[:lastName]).to be_a(String)
    expect(result_user[:lastName]).to eq(user.last_name)
    
    expect(result_user[:email]).to be_a(String)
    expect(result_user[:email]).to eq(user.email)

    expect(message[0]).to eq('User already exists')

    expect(error).to be_empty
  end

  it 'does not create a user with missing fields' do
    user = build(:user)

    query_string = <<-GRAPHQL
     mutation {
       createUser(input: {firstName: "", lastName: "#{user.last_name}", email: "#{user.email}"}) {
          user {
            firstName
            lastName
            email
          }
          message
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string}

    result = JSON.parse(response.body, symbolize_names: true)[:data][:createUser]
    error = result[:error]
    message = result[:message]
    result_user = result[:user]

    expect(error[0]).to eq('First name can\'t be blank')
    expect(message).to be_empty 
    expect(result_user).to be_nil
  end
end
