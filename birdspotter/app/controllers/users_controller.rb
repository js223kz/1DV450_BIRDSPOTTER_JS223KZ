class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  
  #instansiate a new user 
  #for registration form
  def new
    @user = User.new
  end
  
  #register a new user
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
  
  #users account page
  def show
    @user = User.find(params[:id])
    @apikey  = @user.apikeys.build
    if current_user.admin
      @apikeys = Apikey.all.paginate(page: params[:page], per_page: 5)
    else
      @apikeys = current_user.apikeys.paginate(page: params[:page], per_page: 5)
    end
  end
  
  #use of strong params ensure that
  #only permitted parameters are allowed
  private
    
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end 

