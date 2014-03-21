class Api::V1::UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :show]
  respond_to :json

  def show
    if params[:user_id].present?
      user = User.find(params[:user_id])
    else
      user = current_user
    end
    if user
      render :json => {:info => "Current User", :user => user, :sign_in_count => user.sign_in_count}, :status => 200
    else
      render :json => {}, :status => 401
    end
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      sign_in(@user)
      respond_with @user, :location => api_users_path
    else
      respond_with @user.errors, :location => api_users_path
    end
  end

  def update
    respond_with :api, User.update(current_user.id, user_params)
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
    end
end
