module Api
  module V1
    class UsersController < ApplicationController
        def signin
            render json: {status: "success"}
        end
    
        def signup
            render json: {status: "success"}
        end
      end
  end
end