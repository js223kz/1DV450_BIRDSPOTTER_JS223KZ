class Api::V1::Bird < ActiveRecord::Base
    has_and_belongs_to_many :spots
    before_save {self.bird_name = bird_name.downcase}
    before_save {self.latin_name = latin_name.downcase}
    
    validates   :bird_name, 
                :presence => {
                    :message => 'A bird must have a name.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'This birds name already exists.'
                }
    
    validates   :latin_name, 
                :presence => {
                    :message => 'Bird must have a latin name.'
                },
                :uniqueness => { 
                    case_sensitive: false,
                    :message => 'This birds latin name already exists.'
                }
    
    validates   :regularity, 
                :presence => {
                    :message => 'Bird must a regularity tag.'
                }
end
