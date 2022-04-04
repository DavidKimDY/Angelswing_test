require 'rails_helper'

RSpec.describe Project, type: :request do
  describe 'Post /api/v1/projects' do
    context 'with valid paramaters' do
      before do
        file = fixture_file_upload('/Users/daeyeob/Work/angelswing_api/img/disney_land.jpeg')
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        post '/api/v1/projects', params:{
          title: "Disney Land A",
          description: "Wonderful Disney Land",
          type: "international",
          location: "London",
          thumbnail: file
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'creates projects' do
        expect(response).to have_http_status(:success)
      end
      
      it 'has ownerName' do
        ownerName = JSON.parse(response.body)['data']['attributes']['ownerName']
        expect(@user.first_name + ' ' + @user.last_name).to eq(ownerName)
      end

      it 'uploads thumbnail image and return url is 200' do
        thumbnail = JSON.parse(response.body)['data']['attributes']['thumbnail']
        uri = URI(thumbnail)
        res = Net::HTTP.get_response(uri)
        expect(res.code).to eq("200")
      end
    end
    context 'with invalid paramaters' do
      before do
        file = fixture_file_upload('/Users/daeyeob/Work/angelswing_api/img/disney_land.jpeg')
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        post '/api/v1/projects', params:{
          title: "Disney Land A",
          description: "Wonderful Disney Land",
          type: "international",
          location: "London",
          #thumbnail: file
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end
      it 'test' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
    context 'with invalid Authorization' do
      before do
        file = fixture_file_upload('/Users/daeyeob/Work/angelswing_api/img/disney_land.jpeg')
        post '/api/v1/projects', params:{
          title: "Disney Land A",
          description: "Wonderful Disney Land",
          type: "international",
          location: "London",
          thumbnail: file
        } 
      end
      it 'can not create project because of no token' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

