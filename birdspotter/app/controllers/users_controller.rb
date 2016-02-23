class UsersController < ApplicationController
  before_action :logged_in?, only: [:show]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
      if @user.save
        log_in @user
        flash[:success] = "Välkommen till ditt Birdspotterkonto"
        redirect_to @user
      else
        render 'new'
      end
  end
  
  def show
    @user = User.find(params[:id])
    @apikey  = current_user.apikeys.build
    @apikeys = current_user.apikeys.paginate(page: params[:page], per_page: 5)
  end
  
  
  #use of strong params ensure that
  #only permitted parameters are allowed
  private
    
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end 

