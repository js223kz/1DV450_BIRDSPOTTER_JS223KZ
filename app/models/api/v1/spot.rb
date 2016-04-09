class Api::V1::Spot < ActiveRecord::Base
    belongs_to :birdspotter
    
    before_save { 
        self.latitude = latitude.to_float,
        self.latin_name = longitude.to_float
    }
    
    validates   :latitude, 
                :presence => {
                    :message => 'Spot måste innehålla latitude'
                }
    validates   :longitude, 
                :presence => {
                    :message => 'Spot måste innehålla latitude'
                }
end
