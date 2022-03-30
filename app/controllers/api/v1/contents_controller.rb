module Api
  module V1
    class ContentsController < ApplicationController
        def create
          render json: {status: "Success"}
        end

        def update
          render json: {status: "Success"}
        end

        def read
          render json: {status: "Success"}
        end
        
        def read_all_in_project
          render json: {status: "Success"}
        end

        def delete
          render json: {status: "Success"}
        end
      end
  end
end
