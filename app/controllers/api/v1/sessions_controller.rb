class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      render json: UsersSerializer.new(user), status: 200
    else
      render json: {message: 'unsuccessful', error: 'Email/Password Incorrect'}, status: 400
    end
  end

  private

  def session_params
    JSON.parse(request.body.string, symbolize_names: true)
  end
end