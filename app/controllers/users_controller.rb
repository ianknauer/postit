class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]
  
  def new
    @user = User.new
  end
  
  def show
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You are registered!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :time_zone)
  end
  
  def set_user
     @user = User.find_by(username: params[:id])
  end
  
end