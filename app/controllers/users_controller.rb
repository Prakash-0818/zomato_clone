# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]
  before_action :require_user, only: %i[edit show]
  before_action :require_same_user, only: [:edit]
  before_action :require_admin, only: [:destroy]

  def index
    @restaurant = Restaurant.search(params[:q].present? ? params[:q] : '*').records.order('created_at ASC')
  end

  def new
    redirect_to users_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to :root, flash: { success: 'logged in successfully!' }
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path, flash: { success: 'profile updated successfully!' }
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    unless current_user == @user
      flash[:danger] = 'You can edit your own account!'
      redirect_to error_path
    end
  end
end
