class Api::V1::SpotsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :destroy_session
    before_filter :authenticate_birdspotter_from_token, :only => [:create, :destroy, :update]
    before_filter :authenticate_developer_key
    
    def spots
        @birdspotter = params[:birdspotter]
        @bird = params[:bird]
        @spots = Api::V1::Spot.all
        @birds = Api::V1::Bird.all
        
        #get all spots
        if @birdspotter.blank? && @bird.blank?
            render json: { 
                message: "200 OK" , 
                totalCount: @spots.count, 
                spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
            },
            status: 200
            return
        end
        
        #get all spots by birdspotter id
        if !@birdspotter.blank? && @bird.blank?
            if @spots.exists?(@birdspotter)
                @spots = @spots.where(birdspotter_id: @birdspotter)
                render json: { 
                    status: 200, 
                    totalCount: @spots.count,
                    spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
                }
            else
                render json: {
                    message: "There are no spots created by a birdspotter with that id" 
                },
                status: 404
            end
        end
        
        #get all spots by bird id
        if @birdspotter.blank? && !@bird.blank?
            if @birds.exists?(@bird)
                @bird = Api::V1::Bird.find(@bird)
                @spots = @bird.spots
                render json: { 
                    message: "200 OK", 
                    totalCount: @spots.count,
                    spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
                },
                status: 200
            else
                render json: {
                    message: "There are no spots that contains a bird with that id" 
                },
                status: 404
            end
        end
    end
    
    #get spot by id
    def spot
        spot = Api::V1::Spot.find(params[:id])
        render json: {
            message: "200 OK",
            spot: Api::V1::SpotSerializer.new(spot), 
        },
        status: 200
    end
    
    #create a new spot
    def create
        #birdspotter id must be present
        if  spot_params[:birdspotter].blank?
            render json: {
               message: "Creator id must be present." 
            },
             status: 400
            return
        end
        
        #at least one bird must be present
        if  spot_params[:bird].blank?
            render json: {
                message: "A Spot must have at least one bird." 
            },
            status: 400
            return
        end
        
        #check if birdspotter exists
        if Api::V1::Birdspotter.exists?(spot_params[:birdspotter])
            
            #if exists find birdspotter
            @birdspotter = Api::V1::Birdspotter.find_by_id(spot_params[:birdspotter])
            
            #create a new spot and append to birdspotter
            @spot = Api::V1::Spot.create(:latitude =>  spot_params[:latitude], :longitude => spot_params[:longitude])
            if @spot.save
                @birdspotter.spots << @spot
                
                #iterate through all birds and append each bird to newly created spot
                 spot_params[:bird].tr(' ','').split(',').each do |bird_id|
                    if Api::V1::Bird.exists?(bird_id)
                        @bird = Api::V1::Bird.find_by_id(bird_id)
                        @spot.birds << @bird
                   else
                        render json: {
                           message:  "One or several bird id:s doesn't exist."
                        },
                        status: 404
                        return
                    end
                end
            else
                render json: {
                    message:  @spot.errors.full_messages 
                },
                 status: 400
                return
            end
        else
           render json: {
                message: "Birdspotter with that id not found" 
            },
              status: 404
            return
        end
        render json: { 
            message: "Spot was succesfully created", 
            spots: Api::V1::SpotSerializer.new(@spot) 
        },
        status: 201
    end
    
    def destroy
        if Api::V1::Spot.exists?(params[:id])
            @spot = Api::V1::Spot.find(params[:id])
            @spot.destroy
            render json: {
                message: "Spot was deleted"
            },
            status: 204
            
        else
           render json: {
                message: "Spot with that id not found"
            },
            status: 404
            
        end
    end
    
    def update
      @spot = Api::V1::Spot.find(params[:id])
      @spot.birds = []
        if @spot.nil?  
            render json: {
                message: "Spot with that id not found"
            },
            status: 404
        else
            #iterate through all birds
            spot_params[:bird].tr(' ','').split(',').each do |bird_id|
                if Api::V1::Bird.exists?(bird_id)
                    @bird = Api::V1::Bird.find_by_id(bird_id)
                    @spot.birds.push(@bird)
               else
                    render json: {
                        message:  "One or several bird id:s doesn't exist."
                    },
                    status: 404
                    return
                end
            end
            @spot.update_attributes(spot_params.permit(:latitude, :longitude, :birds => @spot.birds))
            render json: {
                message: "Spot has been updated",
                spots: Api::V1::SpotSerializer.new(@spot) 
            },
            status: 200
        end
    end
    
    private
    def spot_params
        json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
        json_params[:spot]
    end
end
