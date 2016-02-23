module LoginHelper
    
    # sets session when user id logged in
    # temporary sessions instantiated with the session method
    # are automatically encrypted and therefor secure
    def log_in(user)
        session[:user_id] = user.id
    end
    
    # if current user is set then return that
    # or if not set, find user and set current user
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # if user is logged in this returns true
    def logged_in?
        !current_user.nil?
    end
    
    #logout user and delete session
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

end
