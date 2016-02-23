class ApikeysController < ApplicationController
  before_action :logged_in?, only: [:create, :destroy]

  def create
    @apikey = current_user.apikeys.build(apikey_params)
    if @apikey.save
      flash[:success] = "Du har registrerat en ny applikation."
      
      #this redirects user to page that
      #issued create
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Du måste namnge din applikation."
      redirect_to request.referrer || root_url
    end
  end
  
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
