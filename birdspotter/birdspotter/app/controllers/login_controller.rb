class LoginController < ApplicationController

  def login
    @user = User.find_by(username: params[:login][:username].downcase)
    if @user && @user.authenticate(params[:login][:password])
      log_in @user
      flash.now[:success] = "Hej #{@user.username}"
      redirect_to @user
    else
      flash.now[:danger] = "Ogiltigt användarnamn/lösenord"
      render 'new'
    end
  end
  
  def logout
    log_out
    redirect_to root_url
  end
end
