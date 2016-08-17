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
                status: 200,
                message: "OK", 
                totalCount: @spots.count, 
                spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
            }
        end
        
        #get all spots by birdspotter id
        if !@birdspotter.blank? && @bird.blank?
            if @spots.exists?(@birdspotter)
                @spots = @spots.where(birdspotter_id: @birdspotter)
                render json: { 
                    status: 200, 
                    message: "OK", 
                    totalCount: @spots.count,
                    spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
                }
            else
                render json: {
                    status: 404,
                    message: "Du har inte registrerat några birdspots ännu. Fram med kikaren!" 
                }
            end
        end
        
        #get all spots by bird id
        if @birdspotter.blank? && !@bird.blank?
            if @birds.exists?(@bird)
                @bird = Api::V1::Bird.find(@bird)
                @spots = @bird.spots
                render json: { 
                    status: 200,
                    message: "OK", 
                    totalCount: @spots.count,
                    spots: ActiveModel::ArraySerializer.new(@spots, each_serializer: Api::V1::SpotSerializer) 
                }
            else
                render json: {
                    status: 404,
                    message: "Det finns inga birdspots med det id:t." 
                }
                
            end
        end
    end
    
    #get spot by id
    def spot
        if Api::V1::Spot.exists?(params[:id])
            spot = Api::V1::Spot.find(params[:id])
            render json: {
                status: 200,
                message: "OK",
                spot: Api::V1::SpotSerializer.new(spot), 
            }
        else
            render json: {
            status: 404,
            message: "Det finns ingen birdspot med det id:t."
        }
        end
    end
    
    #create a new spot
    def create
        #birdspotter id must be present
        if  params[:birdspotter].blank?
            render json: {
                status: 400,
                message: "Skaparens id saknas." 
            }
        end
        
        #at least one bird must be present
        if  params[:bird].blank?
            render json: {
                status: 400,
                message: "En birdspot måste innehålla minst en fågel." 
            }
        end
        
         #latitude and longitude must be present
        if  params[:latitude].blank? || params[:longitude].blank?
            render json: {
                status: 400,
                message: "En birdspot måste innehålla latitud och longitude." 
            }
        end
        
        #check if birdspotter exists
        if Api::V1::Birdspotter.exists?(params[:birdspotter])
            
            #if exists find birdspotter
            @birdspotter = Api::V1::Birdspotter.find_by_id(params[:birdspotter])
            
            #create a new spot and append to birdspotter
            @spot = Api::V1::Spot.create(:latitude =>  params[:latitude], :longitude => params[:longitude])
            if @spot.save
                @birdspotter.spots << @spot
                
                #iterate through all birds and append each bird to newly created spot
                 params[:bird].tr(' ','').split(',').each do |bird_id|
                    if Api::V1::Bird.exists?(bird_id)
                        @bird = Api::V1::Bird.find_by_id(bird_id)
                        @spot.birds << @bird
                    else
                        render json: {
                            status: 404,
                            message:  "En eller flera fåglar med det id:t finns inte."
                        }
                    end
                end
            else
                render json: {
                    status: 400,
                    message:  @spot.errors.full_messages 
                }
            end
        else
           render json: {
                status: 404,
                message: "Skapare med det id:t finns inte." 
            }
            
        end
        
        render json: { 
            status: 201,
            message: "Din birdspot är registerad. Tack!", 
            spots: Api::V1::SpotSerializer.new(@spot) 
        }
    end
    
    def destroy
        if Api::V1::Spot.exists?(:id => params[:id])
            @spot = Api::V1::Spot.find(params[:id])
            @spot.destroy
            render json: {
                status: 204,
                message: "Birdspot raderades."
            }
        else
           render json: {
                status: 404,
                message: "Birdspot med det id:t finns inte."
            }
        end
    end
    
    def update
        if Api::V1::Spot.exists?(:id => params[:id])
            @spot = Api::V1::Spot.find(params[:id])
            @spot.birds = []
            
            #iterate through all birds
            params[:bird].tr(' ','').split(',').each do |bird_id|
                if Api::V1::Bird.exists?(bird_id)
                    @bird = Api::V1::Bird.find_by_id(bird_id)
                    @spot.birds.push(@bird)
                else
                    render json: {
                        status: 404,
                        message:  "En eller flera fåglar med det id:t finns inte."
                    }
                end
            end
        @spot.update_attributes(params.permit(:latitude, :longitude, :birds => @spot.birds))
        render json: {
            status: 200,
            message: "Din birdspot har uppdaterats.",
            spots: Api::V1::SpotSerializer.new(@spot) 
            }
        else
            render json: {
                status: 404,
                message: "Birdspot med det id:t finns inte."
            }
        end
    end
end