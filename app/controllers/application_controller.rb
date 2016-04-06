class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #http_basic_authenticate_with application_key: "kjasgfuegfugfjbvnbhvdg6762811ghjfew"
  before_filter :restrict_access
  include LoginHelper
  
  
  def logged_in_user
    if logged_in?
      logged_in?
    else
      flash[:danger] = "Du måste logga in."
      redirect_to root_url
    end
  end
  
  def restrict_access
    apikey = Apikey.find_by(application_key: params[:key])
    head :unauthorized, text: "Valid apikey is required to interact with api. Get a key at: " unless apikey
  end

end
