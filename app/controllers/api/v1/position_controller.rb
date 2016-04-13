class Api::V1::PositionController < ApplicationController
    
    def spots_nearby
        @lat = params[:lat]
        @lng = params[:lng]
        @offset = params[:offset]
        @spots = Api::V1::Spot.near([@lat, @lng], @offset, :units => :km)
        render json:{
            message: "200 OK",
            totalCount: @spots.count,
            spots:ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
        }, status: 200
    end
end
