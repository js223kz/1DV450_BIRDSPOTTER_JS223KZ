class Api::V1::Spot < ActiveRecord::Base
    belongs_to :birdspotter
    has_and_belongs_to_many :birds

    validates   :latitude,
                :numericality => true,
                :presence => {
                    :message => 'Latitude needs to be specified'
                }
    
    validates   :longitude, 
                :numericality => true,
                :presence => {
                    :message => 'Longitude needs to be specified'
                }
    
   
end
