class Api::V1::PositionController < ApplicationController
    
    def spots_nearby
        @lat = params[:lat]
        @lng = params[:lng]
        @offset = params[:offset]
        
        if @lat.blank?
           render json:{
                status: 400,
                message: "Latitud måste anges.",
            }  
        end
        
        if @lng.blank?
           render json:{
                status: 400,
                message: "Longitude måste anges.",
            }  
        end
        
        if @offset.blank?
           render json:{
                status: 400,
                message: "Ett avstånd i km måste anges.",
            }  
        end
        
        @spots = Api::V1::Spot.near([@lat, @lng], @offset, :units => :km)
        render json:{
            status: 200,
            message: "200 OK",
            spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
        } 
    end
end
