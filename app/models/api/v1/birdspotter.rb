class Api::V1::Birdspotter < ActiveRecord::Base
    include ActiveModel::Serialization
    
    before_save { self.email = email.downcase }
    before_create { self.user_token = SecureRandom.hex(32) }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    
    validates :user_name, 
                :presence => {
                    :message => 'Du måste fylla i ett användarnamn.'
                        }, 
                :length => { 
                    maximum: 30,
                    minimum: 4,
                    too_long: 'Användarnamn kan max vara 30 tecken.',
                    too_short: 'Användarnamn måste bestå av minst 4 tecken'
                }, 
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Användarnamnet finns redan.'
                }
                
    validates :email, 
                :presence => {
                    :message => 'Du måste fylla i en e-postadress.'
                        }, 
                :length => { 
                    maximum: 70,
                    too_long: 'E-post kan max vara 70 tecken.'
                }, 
                :format => { 
                    with: VALID_EMAIL_REGEX,
                    :message => 'E-postadressen verkar vara i ogiltigt format.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'E-postadressen finns redan.'
                    
                }
    
    has_secure_password
    validates :password, 
                :presence =>{
                    :message => 'Du måste fylla i ett lösenord'
                    },
                length: { 
                    minimum: 6,
                    too_short: 'Lösenordet måste vara minst 6 tecken.'
                }
    
    # Returns the hash digest of the given string at min cost 
    # in testing and normal high cost in production
    def Birdspotter.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
