class User < ActiveRecord::Base
    
    #validera att det inte är kortare än 6 bokstäver
    #strippa från skadlig kod
    validates :username, presence:true
    
    #validera att det är ett password
    #strippa från skadlig kod
    validates :password, presence:true
end
