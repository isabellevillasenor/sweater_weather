require 'rails_helper'

describe 'User Registration Controller' do
  it 'creates a user' do
    user_params = {
      email: 'gon@hxh.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(201)
    expect(User.last.email).to eq(user_params[:email])
  end

  it 'retrieves serialized user data' do
    user_params = {
      email: 'gon@hxh.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json' }

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    result = JSON.parse(response.body, symbolize_names: true)

    user = User.last

    expect(result[:data][:type]).to eq('users')
    expect(result[:data][:id]).to eq(user.id.to_s)
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data][:attributes]).to have_key(:email)
    expect(result[:data][:attributes][:email]).to eq(user.email)

    expect(result[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'sends a 404 error when unable to save user' do
    user_params = {
      email: 'gon@hxh.com',
      password: 'pAsSwOrD',
      password_confirmation: 'passWord'
    }

    headers = {'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/users', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(404)
  end
end