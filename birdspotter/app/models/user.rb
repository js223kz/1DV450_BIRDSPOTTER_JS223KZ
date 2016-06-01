class User < ActiveRecord::Base
    has_many :apikeys, :dependent => :destroy
    before_save { self.username = username.downcase }
    
    VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :username, 
                :presence => {
                    :message => 'Du måste fylla i ett användarnamn.'
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
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
