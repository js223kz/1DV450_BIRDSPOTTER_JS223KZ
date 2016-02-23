class User < ActiveRecord::Base
    has_secure_password
    has_many :apikeys, :dependent => :destroy
    before_save { self.username = username.downcase }
    
    validates   :username, 
                :presence => {:message => "Du måste ange en e-post."}, 
                :uniqueness => { case_sensitive: false, 
                                :message => "E-postadressen finns redan." }

    validates_format_of :username,
                        :with => /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                        :presence => {:message => "E-post har angivits i ett felaktigt format."}
    
    validates   :password, 
                :presence => {:message => "Du måste ange ett lösenord."}, 
                :length => { minimum: 6, :message => "Löseordet måste innehålla minst 6 tecken."}
    
    # Returns the hash digest of the given string at min cost 
    # in testing and normal high cost in production
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
