class Apikey < ActiveRecord::Base
    belongs_to :user
    before_create { self.application_key = SecureRandom.hex(32) }
    default_scope -> { order(created_at: :desc) }
    
    validates   :user_id, 
                :presence => true
    
    validates   :application_name, 
                :presence => {
                    :message => 'Du måste ge applikationen ett namn'},
                :length => { 
                    minimum: 4, 
                    maximum: 70, 
                    too_short: "Applikationsnamnet måste innehålla minst 4 tecken.",
                    too_long: "Applikationsnamnet får inte innehålla mer än 70 tecken." }
end
