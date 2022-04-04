require 'rails_helper'

RSpec.describe Project, type: :request do
  describe 'Put /api/v1/projects' do
    context 'with valid paramaters' do
      before do
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @project = Project.find_by({'user_id':@user.id})
        put "/api/v1/projects/#{@project.id}", params:{
          title: "Updated",
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'updated a project' do
        expect(response).to have_http_status(:success)
      end
      
      it 'updated a title of a project' do
        updated_project = Project.find(@project.id)
        expect(updated_project.title).to eq("Updated")
      end
    end

    context 'with invalid paramaters' do
      before do
        @user, @another_user = User.find_by_sql('select * from users limit 2')
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @another_project = Project.find_by({'user_id': @another_user.id})
        put "/api/v1/projects/#{@another_project.id}", params:{
          title: "Updated",
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end
      it "can not update other's project" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

