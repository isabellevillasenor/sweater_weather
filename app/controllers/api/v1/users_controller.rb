class Api::V1::UsersController < ApplicationController
  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('users')
    user = User.new(user_params)
    if user.save
      render json: UsersSerializer.new(user), status: 201
    else
      render json: { message: 'unsuccessful', error: 'Could Not Create User'}, status: 404 
    end
  end
  
  private
  
  def user_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end