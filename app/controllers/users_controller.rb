class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      render status: 200
    else
      render @user.errors, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:phone, :password)
  end
end
