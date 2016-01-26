class User < ActiveRecord::Base
    
    has_many :applications
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    #strippa från skadlig kod
    validates :username, presence:true, length: { maximum: 255 }, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    
    
    #strippa från skadlig kod
    validates :password, presence:true, length: { minimum: 6, maximum: 255 }
end
