# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: %i[login signup]

  def login
    @user = User.find_by_phone(session_params[:phone])

    if @user&.authenticate session_params[:password]
      @payload = JsonWebToken.encode user_id: @user.id
    else
      head :bad_request
    end
  end

  def signup
    @user = User.new(session_params)

    if @user.save
      @payload = JsonWebToken.encode user_id: @user.id
      render 'signup', status: :created
    else
      render json: { erorrs: @user.errors }, status: :bad_request
    end
  end

  def logout
    head :not_implemented
  end

  private

  def session_params
    params.require(:user).permit(:phone, :password)
  end
end
