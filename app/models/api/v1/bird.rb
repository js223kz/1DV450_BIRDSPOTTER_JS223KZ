class Api::V1::Bird < ActiveRecord::Base
    before_save { 
        self.bird_name = bird_name.downcase,
        self.latin_name = latin_name.downcase
    }
    
    validates   :bird_name, 
                :presence => {
                    :message => 'En fågel måste ha ett namn.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Fågelns namn finns redan i listan'
                }
    
    validates   :latin_name, 
                :presence => {
                    :message => 'En fågel måste ha ett latinskt namn.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'Fågelns latinska namn finns redan i listan'
                }
    
    validates   :regularity, 
                :presence => {
                    :message => 'En fågel måste ha en beteckning som anger hur vanlig den är.'
                }
end
