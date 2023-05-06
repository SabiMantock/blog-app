class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :update_allowed_parameters, if: :devise_controller?
  def index
    @users = User.all
    @current_user = current_user
  end

  def show
    @user = User.find(params[:id])
  end
end
