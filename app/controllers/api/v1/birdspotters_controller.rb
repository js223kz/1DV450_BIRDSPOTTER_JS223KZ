class Api::V1::BirdspottersController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session
    before_filter :authenticate_developer_key

    # get all birdspotters
    def birdspotters
        birdspotters = Api::V1::Birdspotter.all
        render json: {
            status: 200,
            message: "OK",
            totalCount: birdspotters.count,
            spots: ActiveModel::ArraySerializer.new(birdspotters, each_serializer: Api::V1::BirdspotterSerializer)
        } 
    end
    
    #get birdspotter by id
    def birdspotter
        birdspotter = Api::V1::Birdspotter.find(params[:id])
        render json: {
            status: 200,
            message: "OK",
            birdspotter: Api::V1::BirdspotterSerializer.new(birdspotter) 
        }
    end
end
 