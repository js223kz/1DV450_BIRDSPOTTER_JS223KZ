class Api::V1::SpotsController < ApplicationController
    
    def spots
        
        @birdspotter = params[:birdspotter]
        @bird = params[:bird]
        @spots = Api::V1::Spot.all
        @birds = Api::V1::Bird.all
        
        if @birdspotter.blank? && @bird.blank?
            render json: { 
                status: 200, 
                totalCount: @spots.count, 
                spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
            }
            return
        end
        
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
                    error: 404,
                    message: "There are no spots created by a birdspotter with that id" 
                } 
            end
        end
        
        if @birdspotter.blank? && !@bird.blank?
            if @birds.exists?(@bird)
                @bird = Api::V1::Bird.find(@bird)
                @spots = @bird.spots
                render json: { 
                        status: 200, 
                        totalCount: @spots.count,
                        spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
                }
            else
                render json: {
                    status: 404,
                    message: "There are no spots that contains a bird with that id" 
                }   
            end
        end
    end
    
    def spot
        spot = Api::V1::Spot.find(params[:id])
        render json: spot
    end
    
    def create
        if params[:birdspotter].blank?
            render json: {
                error: 400,
                message: "Creator id must be present." 
            }
            return
        end
        
        if params[:bird].blank?
            render json: {
                error: 400,
                message: "A Spot must have at least one bird." 
            }
            return
        end
        
        if Api::V1::Birdspotter.exists?(params[:birdspotter])
            @birdspotter = Api::V1::Birdspotter.find_by_id(params[:birdspotter])
            @spot = Api::V1::Spot.create(:latitude => params[:latitude], :longitude => params[:longitude])
            if @spot.save
                @birdspotter.spots << @spot
                
                params[:bird].tr(' ','').split(',').each do |bird_id|
                    if Api::V1::Bird.exists?(bird_id)
                        @bird = Api::V1::Bird.find_by_id(bird_id)
                        @spot.birds << @bird
                   else
                        render json: {
                            status: 404,
                            message:  "One or several bird id:s doesn't exist."
                        } 
                        return
                    end
                end
            else
                render json: {
                    error: 400,
                    message:  @spot.errors.full_messages 
                }
                return
            end
        else
           render json: {
                error: 404,
                message: "Birdspotter with that id not found" 
            }
            return
        end
        render json: { 
            status: 201, 
            message: "Spot was succesfully created", 
            spots: Api::V1::SpotSerializer.new(@spot) 
        }
    end
    
    def destroy
        if Api::V1::Spot.exists?(params[:id])
            @spot = Api::V1::Spot.find(params[:id])
            @spot.destroy
            render json: {
                status: 204,
                message: "Spot was deleted"
            }
        else
           render json: {
                status: 404,
                message: "Spot with that id not found"
            } 
        end
    end
    
    def update
      @spot = Api::V1::Spot.find(params[:id])
      @spot.birds = []
        if @spot.nil?  
            render json: {
                status: 404,
                message: "Spot with that id not found"
            } 
        else
            params[:bird].tr(' ','').split(',').each do |bird_id|
                if Api::V1::Bird.exists?(bird_id)
                    @bird = Api::V1::Bird.find_by_id(bird_id)
                    @spot.birds.push(@bird)
               else
                    render json: {
                        status: 404,
                        message:  "One or several bird id:s doesn't exist."
                    } 
                    return
                end
            end
            @spot.update_attributes(params.permit(:latitude, :longitude, :birds => @spot.birds))
            render json: {
                status: 200,
                message: "Spot has been updated",
                spots: Api::V1::SpotSerializer.new(@spot) 
            } 
        end
    end
end
