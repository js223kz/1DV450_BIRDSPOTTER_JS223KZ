class Api::V1::TokenController < ApplicationController
    
    def authenticate
        @birdspotter = Api::V1::Birdspotter.find_by(username: params[:login][:username].downcase)
        if  @birdspotter &&  @birdspotter.authenticate(params[:login][:password])
          render json:{
              status:200
          }
        else
          render json: {
              status:401
          }
        end
    end
end
