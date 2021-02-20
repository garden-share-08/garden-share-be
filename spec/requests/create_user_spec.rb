require 'rails_helper'

RSpec.describe 'backend createUser mutation request' do
  it 'creates a unique user' do
    user = build(:user)
    query_string = <<-GRAPHQL
     mutation {
       createUser(input: {firstName: "#{user.first_name}", lastName: "#{user.last_name}", email: "#{user.email}"}) {
          user {
            firstName
            lastName
            email
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string }

    result = JSON.parse(response.body, symbolize_names: true)
    user_info = result[:data][:createUser][:user]
    error = result[:data][:createUser][:error]

    expect(error).to be_empty
    expect(user_info[:firstName]).to eq(user.first_name)
    expect(user_info[:lastName]).to eq(user.last_name)
    expect(user_info[:email]).to eq(user.email)
  end

  it 'does not create a user that already exists' do
    user = create(:user)

    query_string = <<-GRAPHQL
     mutation {
       createUser(input: {firstName: "#{user.first_name}", lastName: "#{user.last_name}", email: "#{user.email}"}) {
          user {
            firstName
            lastName
            email
          }
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string}

    result = JSON.parse(response.body, symbolize_names: true)
    error = result[:data][:createUser][:error]

    expect(error[0]).to eq("Email has already been taken")
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
          error
        }
      }
    GRAPHQL

    post graphql_path, params: { query: query_string}

    result = JSON.parse(response.body, symbolize_names: true)
    error = result[:data][:createUser][:error]

    expect(error[0]).to eq('First name can\'t be blank')
  end
end
