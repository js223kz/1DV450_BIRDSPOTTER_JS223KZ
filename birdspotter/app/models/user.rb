class User < ActiveRecord::Base
    has_many :apikeys, :dependent => :destroy
    before_save { self.username = username.downcase }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :username, presence:true, length: { maximum: 70 }, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence:true, length: { minimum: 6}
    
    # Returns the hash digest of the given string at min cost 
    # in testing and normal high cost in production
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
