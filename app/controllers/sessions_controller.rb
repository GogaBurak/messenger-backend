class SessionsController < ApplicationController
  skip_before_action :authorize_request, only: :create

  def create
    @user = User.find_by_phone(session_params[:phone])

    head :unauthorized unless @user&.authenticate session_params[:password]

    token = JsonWebToken.encode { user_id: @user.id }
    time = Time.now + 24.hours

    render json: { token: token, 
                   exp: time.strftime("%m-%d-%Y %H:%M"), 
                   phone: @user.phone 
                 }, head: :ok
  end

  private

  def session_params
    params.require(:session).permit(:phone, :password)
  end
end
