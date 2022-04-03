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
  end
end

