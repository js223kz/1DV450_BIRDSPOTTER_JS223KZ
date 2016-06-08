class Api::V1::Birdspotter < ActiveRecord::Base
    has_many :spots
    before_save { self.email = email.downcase }
    before_create { self.user_token = SecureRandom.hex(32) }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    validates :user_name, 
                :presence => {
                    :message => 'Du måste ange ett användarnamn.'
                        }, 
                :length => { 
                    maximum: 30,
                    minimum: 4,
                    too_long: 'Användarnamnet får vara max 30 tecken.',
                    too_short: 'Användarnamnet måste vara minst 4 tecken långt.'
                }, 
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Användarnamnet existerar redan.'
                }
                
    validates :email, 
                :presence => {
                    :message => 'Du måste ange en e-postadress.'
                        }, 
                :length => { 
                    maximum: 70,
                    too_long: 'E-postadressens längd får max vara 70 tecken.'
                }, 
                :format => { 
                    with: VALID_EMAIL_REGEX,
                    :message => 'E-postadressen är inte giltig.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'E-postadressen existerar redan.'
                    
                }
    
    has_secure_password
    validates :password, 
                :presence =>{
                    :message => 'Du måste ange ett lösenord.'
                    },
                length: { 
                    minimum: 6,
                    too_short: 'Lösenordet måste vara minst 6 tecken långt.'
                }
    
    # Returns the hash digest of the given string at min cost 
    # in testing and normal high cost in production
    def Birdspotter.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
