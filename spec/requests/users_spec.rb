require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Post /signin' do
    context 'with valid paramaters' do
      
      before do
        post '/api/v1/auth/signin', params:{
          auth: {
            email: "kim@gmail.com",
            password: "123123"
          }
        }
      end

      it 'signs in well' do
        expect(response).to have_http_status(:success)
      end
  
      it "returns valid JWT" do
        parsed_response = JSON.parse(response.body)
        token = parsed_response['data']["attributes"]["token"]
        user_id = parsed_response['data']['id']
        decoded_user_id = JWT.decode(token, 'yourSecret', true, algorithm: "HS256")[0]["user_id"]
        expect(decoded_user_id).to eq(user_id)
      end

    end
    context 'with invalid paramaters' do
      before do
        post '/api/v1/auth/signin', params:{
          auth: {
            email: "kim@gmail.com",
            password: ""
          }
        }
      end

      it "can not sign in" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'Post /signup' do
    context 'with valid parameters' do
      before do
        post '/api/v1/users/signup', params:{
          "firstName": "John",
          "lastName": "Doe", 
          "email": "john@email.com",
          "password": "complex_password",
          "country": "USA"
        }
      end
      
      it "signs up well" do
        expect(response).to have_http_status(:success)
      end

      it "returns valid JWT" do
        parsed_response = JSON.parse(response.body)
        token = parsed_response['data']["attributes"]["token"]
        user_id = parsed_response['data']['id']
        decoded_user_id = JWT.decode(token, 'yourSecret', true, algorithm: "HS256")[0]["user_id"]
        expect(decoded_user_id).to eq(user_id)
      end

      it "returns full name" do
        parsed_response = JSON.parse(response.body)
        name = parsed_response["data"]["attributes"]["name"]
        expect(name).to eq("John Doe")
      end
    end
    context 'with invalid paramseters' do
      before do
        post '/api/v1/users/signup', params:{
          "firstName": "John",
          "lastName": "Kim", 
          "email": "kim@gmail.com",
          "password": "complex_password",
          "country": "USA"
        }
      end

      it "can not sign up beacause existed email" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
      before do
        post '/api/v1/users/signup', params:{
          "firstName": "John",
          "lastName": "", 
          "email": "john@gmail.com",
          "password": "complex_password",
          "country": "USA"
        }
      end

      it "can not sign up beacause no required data" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

