class Api::V1::Bird < ActiveRecord::Base
    has_and_belongs_to_many :spots
    before_save {self.bird_name = bird_name.downcase}
    before_save {self.latin_name = latin_name.downcase}
    
    validates   :bird_name, 
                :presence => {
                    :message => 'Fågelns namn måste anges.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Fågeln finns redan.'
                }
    
    validates   :latin_name, 
                :presence => {
                    :message => 'Fågelns latinska namn måste anges.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Fågelns latinska namn finns redan.'
                }
    
    validates   :regularity, 
                :presence => {
                    :message => 'Fågelns regularitet måste anges.'
                }
end
