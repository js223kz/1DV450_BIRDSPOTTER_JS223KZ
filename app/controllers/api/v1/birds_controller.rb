class Api::V1::BirdsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session
    
    #required valid apikey to interact with api
    #before_filter :restrict_access
    
    #get list of birds
    def birds
        @birds = Api::V1::Bird.all
        @serializer = ActiveModel::ArraySerializer

        #if regularity is not defined get all birds
        if params[:regularity].blank?
            render json: { 
                status: 200, 
                totalCount: @birds.count,
                birds: @serializer.new(@birds, each_serializer: Api::V1::BirdSerializer) 
            }
            
        #if regularity is defined get birds based on regularity
        else
            @regularity = params[:regularity].split(",")
            @birds = @birds.where(regularity: @regularity)
            render json: { 
                status: 200, 
                totalCount: @birds.count,
                birds: @serializer.new(@birds, each_serializer: Api::V1::BirdSerializer) 
            }
        end
    end
    
    
    #Get bird by id
    def bird
        bird = Api::V1::Bird.find(params[:id])
        render json: {
            status: 200,
            bird: Api::V1::BirdSerializer.new(bird) 
        } 
    end
end
