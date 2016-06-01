class LoginController < ApplicationController

  def login
    @user = User.find_by(username: params[:login][:username].downcase)
    if  @user &&  @user.authenticate(params[:login][:password])
      log_in  @user
      redirect_to @user
    else
      flash.now[:danger] = 'Ogiltigt användarnamn/lösenord'
      render 'start/start'
    end
  end
  
  def logout
    log_out
    redirect_to root_url
  end
end
