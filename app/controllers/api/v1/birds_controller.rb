class Api::V1::BirdsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session
    before_filter :authenticate_birdspotter_from_token, :only => [:create]
    before_filter :authenticate_developer_key
    
    
    #get list of birds
    def birds
        @birds = Api::V1::Bird.all
        @serializer = ActiveModel::ArraySerializer

        #if regularity is not defined get all birds
        if params[:regularity].blank?
            render json: {
                status: 200,
                message: "OK",
                totalCount: @birds.count,
                birds: @serializer.new(@birds, each_serializer: Api::V1::BirdSerializer) 
            }
            
            
        #if regularity is defined get birds based on regularity
        else
            @regularity = params[:regularity].split(",")
            @birds = @birds.where(regularity: @regularity)
            render json: 
            { 
                status: 200,
                message: "OK",
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
            message: "OK",
            bird: Api::V1::BirdSerializer.new(bird) 
        }
        
    end
    
     #create a new bird
    def create
       #bird name must be present
        if  params[:name].blank?
            render json: {
                status: 400,
                message: "Fågelns namn måste anges." 
            }
        end
        
        #latin name must be present
        if  params[:latin].blank?
            render json: {
                status: 400,
                message: "Fågelns latinska namn måste anges." 
            }
        end
        
        #regularity must be present
        if  params[:regularity].blank?
            render json: {
                status: 400,
                message: "Fågelns regularitet måste anges." 
            }
        end
        
        #check if bird already exists
        if Api::V1::Bird.where(:bird_name => params[:name])
            render json: {
                status: 400,
                message: "Fågeln finns redan" 
            }
        else
         @bird = Api::V1::Bird.create(:bird_name => params[:name], :latin_name => params[:latin], :regularity => params[:regularity])
         @bird.save 
        end
        
        
        render json: {
            status: 201,
            message: "Fågeln är registrerad och finns nu i listan.", 
            bird: Api::V1::BirdSerializer.new(@bird)  
        }
 
    end
end
