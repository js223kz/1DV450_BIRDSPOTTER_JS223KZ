class ApikeysController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  #create new apikey and save to currently
  #logged in user
  def create
    @apikey = current_user.apikeys.build(apikey_params)
    if @apikey.save
      flash[:success] = "Du har registrerat en ny applikation."
    else
      flash[:danger] = "Du måste namnge din applikation."
    end
    
    #this redirects user to page that
    #issued create
    redirect_to request.referrer || root_url
  end
  
  #delete apikey if user is user who created it
  #or admin. Redirect to same page
  def destroy
    @apikey = Apikey.find(params[:id])
    @apikey.destroy
    flash[:success] = "Applikationen är raderad."

    #this redirects user to page that
    #issued delete
    redirect_to request.referrer || root_url
  end
  
  
  private
    def apikey_params
      params.require(:apikey).permit(:application_name)
    end
    
    def correct_user
      @apikey = current_user.apikeys.find_by(id: params[:id])
      redirect_to root_url if @apikey.nil? unless current_user.admin?
    end
    
end
