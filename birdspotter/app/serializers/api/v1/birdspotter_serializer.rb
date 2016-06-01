class Api::V1::BirdspotterSerializer < ActiveModel::Serializer
  attributes :id, :userName
  
  def userName
      object.user_name
  end
end
