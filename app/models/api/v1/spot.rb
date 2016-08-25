class Api::V1::Spot < ActiveRecord::Base
    belongs_to :birdspotter
    has_and_belongs_to_many :birds
    reverse_geocoded_by :latitude, :longitude
    default_scope -> { order(created_at: :desc) }

    validates   :latitude,
                :numericality => true,
                :presence => {
                    :message => 'Latitud måste anges.'
                }
    
    validates   :longitude, 
                :numericality => true,
                :presence => {
                    :message => 'Longitud måste anges.'
                }
    
   
end
