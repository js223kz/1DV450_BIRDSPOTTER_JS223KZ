class Api::V1::BirdSerializer < ActiveModel::Serializer
  attributes :id, :birdName, :latinName, :regularity, :href
  
  def birdName
      object.bird_name
  end
  
  def latinName
      object.latin_name
  end
  
  def href
      "https://birdspotter-apikey-js223kz.c9users.io/api/v1/birds/" + object.id.to_s() 
  end
end
