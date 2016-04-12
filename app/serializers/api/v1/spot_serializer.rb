class Api::V1::SpotSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :birdspotterId, :birdspotterHref, :createdAt, :updatedAt
  
    has_many :birds
    
    def birdspotterId
        object.birdspotter_id
    end
    
    def birdspotterHref
        "https://birdspotter-apikey-js223kz.c9users.io/api/v1/birdspotter/" + object.birdspotter_id.to_s() 
    end
  
    def createdAt
        object.created_at.in_time_zone.iso8601 if object.created_at
    end

  def updatedAt
    object.updated_at.in_time_zone.iso8601 if object.created_at
  end
  
  def href
      "https://birdspotter-apikey-js223kz.c9users.io/api/v1/birds/" + object.id.to_s() 
  end
end
