class Api::V1::BirdSerializer < ActiveModel::Serializer
  attributes :id, :birdName, :latinName, :createdAt, :updatedAt, :href
  def birdName
      object.bird_name
  end
  
  def latinName
      object.latin_name
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
