class Api::V1::Spot < ActiveRecord::Base
    belongs_to :birdspotter

    
    validates   :latitude,
                :numericality => true,
                :presence => {
                    :message => 'Spot måste innehålla latitude'
                }
    validates   :longitude, 
                :numericality => true,
                :presence => {
                    :message => 'Spot måste innehålla latitude'
                }
end
