module LoginHelper
    
    # sets session when developer id logged in
    # temporary sessions instantiated with the session method
    # are automatically encrypted and therefor secure
    def log_in(developer)
        session[:developer_id] = developer.id
    end
    
    # if current developer is set then return that
    # or if not set, find developer and set current developer
    def current_developer
        @urrent_developer ||= Developer.find_by(id: session[:developer_id])
    end
    
    # if developer is logged in this returns true
    def logged_in_dev?
        !current_developer.nil?
    end
    
    #logout developer and delete session
    def log_out_dev
        session.delete(:developer_id)
        @current_developer = nil
    end
end