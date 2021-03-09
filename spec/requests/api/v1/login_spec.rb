require 'rails_helper'

describe 'User Login' do
  it 'sends user email and api key if log in successful' do
    user = create(:user, email: 'gon@hxh.com')

    user_params = {
      email: 'gon@hxh.com',
      password: 'password'
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(200)

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data][:type]).to eq('users')
    expect(result[:data][:id]).to eq(user.id.to_s)
    expect(result[:data]).to have_key(:attributes)
    expect(result[:data][:attributes]).to have_key(:email)
    expect(result[:data][:attributes][:email]).to eq(user.email)

    expect(result[:data][:attributes][:api_key]).to eq(user.api_key)
  end

  it 'sends a 400 error when log in credentials are bad' do
    user = create(:user, email: 'gon@hxh.com')

    user_params = {
      email: 'gon@hxh.com',
      password: 'passW0rdDd'
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}

    post '/api/v1/sessions', headers: headers, params: JSON.generate(user_params)

    expect(response.status).to eq(400)
  end
end