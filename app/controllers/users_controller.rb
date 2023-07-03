class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { error: 'Failed to create user' }, status: :unprocessable_entity
      end
    end
  
    def show
      if logged_in?
        render json: current_user
      else
        render json: { error: 'Not authenticated' }, status: :unauthorized
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
  