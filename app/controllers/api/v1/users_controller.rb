module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def signin
        @user = User.find_by(email: params[:auth][:email])
        puts @user
        if @user && @user.authenticate(params[:auth][:password])
          render json: {data: data}
        else
          render json: {error: "Invalid username or password"}
        end
      end
    
      def signup
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({user_id: @user.id})
          render json: {user: @user, token: token}
        else
          render json: {error: "Invalid username or password"}
        end
      end

      def auto_login
        render json: @user
      end

      private

      def user_params
        params.permit(:firstName, :lastName, :email, :password, :country)
      end

      def data
        data = {
          id: @user.id,
          type: "users",
          attributes: {
            token: encode_token({user_id: @user.id}),
            email: @user.email,
            name: @user.last_name + " " + @user.first_name,
            country: @user.country,
            createdAt: @user.created_at,
            updatedAt: @user.updated_at
          }
        }
        return data
      end
    end
  end
end