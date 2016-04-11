class Api::V1::BirdsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session
    
    #required valid apikey to interact with api
    #before_filter :restrict_access
    
    def birds
        birds = Api::V1::Bird.all

        if params[:regularity].blank?
            render json: {
            totalCount: birds.count,
            birds: birds
          }
        else
          
          params[:regularity].tr(' ','').split(',').each do |keyword|
            birds = Api::V1::Bird.where("regularity like ?", "%#{keyword}%") 
            render json: birds, meta: {totalCount: birds.count}
          end
       
        end
    end
    
    def bird
        bird = Api::V1::Bird.find(params[:id])
        render json: bird
    end
end
