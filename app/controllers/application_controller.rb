class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception
  include LoginHelper
  
  #override default thrown exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  #apiuser can only access api with valid apikey
  def restrict_access
    authenticate_or_request_with_http_token do|token, options|
    Apikey.exists?(application_key: token)
    end
  end
  
  def logged_in_user
    if logged_in?
      logged_in?
    else
      flash[:danger] = "Du måste logga in."
      redirect_to root_url
    end
  end
  
  private
  
  #Overrides default values in request_http_token_authentication built in method
  def request_http_token_authentication(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render :json => {
      :error => "HTTP Token: Access denied due to missing or invalid apikey. Please add you apikey as Authorization header",
      :key => "Get your own apikey for free here: "
      
    }, :status => :unauthorized
  end
  
  def not_found
    respond_to do |format|
      format.json { render json: { error: '404, not found' }, status: 404 }
    end
  end
end
