class Api::V1::Birdspotter < ActiveRecord::Base
    has_many :spots
    before_save { self.email = email.downcase }
    before_create { self.user_token = SecureRandom.hex(32) }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    validates :user_name, 
                :presence => {
                    :message => 'You must enter a username.'
                        }, 
                :length => { 
                    maximum: 30,
                    minimum: 4,
                    too_long: 'Username length is maximum 30 characters.',
                    too_short: 'Username length is minimum 4 characters.'
                }, 
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Username already exists.'
                }
                
    validates :email, 
                :presence => {
                    :message => 'You must enter an email address.'
                        }, 
                :length => { 
                    maximum: 70,
                    too_long: 'E-mail length is maximum 70 characters.'
                }, 
                :format => { 
                    with: VALID_EMAIL_REGEX,
                    :message => 'E-mail address is not valid.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'E-mail address already exists.'
                    
                }
    
    has_secure_password
    validates :password, 
                :presence =>{
                    :message => 'You must enter a password.'
                    },
                length: { 
                    minimum: 6,
                    too_short: 'Password length is minimum 6 characters.'
                }
    
    # Returns the hash digest of the given string at min cost 
    # in testing and normal high cost in production
    def Birdspotter.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
