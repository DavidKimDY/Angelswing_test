require 'rails_helper'

RSpec.describe Content, type: :request do
  describe 'Post /api/v1/project/:project_id/contents' do
    context 'with valid paramaters' do
      before do
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @project = Project.find_by({"user_id": @user.id})
        post "/api/v1/projects/#{@project.id}/contents", params:{
          content:{
          title: "Details",
          body: "Details about this project",
          }
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'creates contents' do
        expect(response).to have_http_status(:success)
      end
       
      it 'has projectOwnerName' do
        ownerName = JSON.parse(response.body)['data']['attributes']['projectOwnerName']
        expect(@user.first_name + ' ' + @user.last_name).to eq(ownerName)
      end
    end
    context 'with invalid Authorization' do
      before do
        @user, @another_user = User.find_by_sql('select * from users limit 2')
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @another_project = Project.find_by({"user_id": @another_user.id})
        post "/api/v1/projects/#{@another_project.id}/contents", params:{
          content:{
          title: "Details",
          body: "Details about this project",
          }
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it "can not create contents into other's project" do
        expect(response).to have_http_status(:unauthorized)
      end
    end 
    context 'with invalid paramaters' do
      before do
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @project = Project.find_by({"user_id": @user.id})
        post "/api/v1/projects/#{@project.id}/contents", params:{
          content:{
          title: "Details",
          }
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'can not create contents because of no required data' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

