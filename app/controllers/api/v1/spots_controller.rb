class Api::V1::SpotsController < ApplicationController
    
    def spots
        spots = Api::V1::Spot.all
        render json: spots, meta: {totalCount: spots.count}
    end
    
    def spot
        spot = Api::V1::Spot.find(params[:id])
        render json: spot
    end
    
    def create
        if params[:birdspotter].blank?
            render json: {
                error: 401,
                text: "Creator id must be present." 
            }
            return
        end
        
        if params[:bird].blank?
            render json: {
                error: 401,
                text: "A Spot must have at least one bird." 
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
                            errors:  "One or several bird id:s doesn't exist."
                        } 
                        return
                    end
                end
            else
                render json: {
                errors:  @spot.errors.full_messages 
                }
                return
            end
        else
           render json: {
                error: 404,
                text: "Birdspotter with that id not found" 
            }
            return
        end
        render json: @spot, meta:{status: 201, text: "Spot was succesfully created"}
            
            
    end
end
