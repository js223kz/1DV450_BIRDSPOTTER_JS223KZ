class Api::V1::BirdspottersController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session

    #required valid apikey to interact with api
    #before_filter :restrict_access
    
    def birdspotters
        birdspotters = Api::V1::Birdspotter.all
        render json: birdspotters, meta: {totalCount: birdspotters.count}
    end
    
    def birdspotter
        birdspotter = Api::V1::Birdspotter.find(params[:id])
        render json: birdspotter
    end
end
