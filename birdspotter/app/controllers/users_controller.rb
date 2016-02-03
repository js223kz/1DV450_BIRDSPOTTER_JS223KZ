class UsersController < ApplicationController
  
  
  def new
    @user = User.new
  end
  
  
  def create
    @user = User.new(params[user_params])
      if @user.save
        #redirect_to @user
      else
        render 'new'
      end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  
  #use of strong params ensure that
  #only permitted parameters are allowed
  private
    
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
  
  
 end 

