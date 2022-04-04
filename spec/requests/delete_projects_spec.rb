require 'rails_helper'

RSpec.describe Project, type: :request do
  describe 'Delete /api/v1/projects' do
    context 'with valid paramaters' do
      before do
        @user = User.find_by({email: "kim@gmail.com"})
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @project = Project.find_by({'user_id':@user.id})
        delete "/api/v1/projects/#{@project.id}",
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'deletes a project' do
        expect(response).to have_http_status(:success)
      end
    end
    context 'with invalid paramaters' do
      before do
        @user, @another_user = User.find_by_sql('select * from users limit 2')
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @another_project = Project.find_by({'user_id': @another_user.id})
        delete "/api/v1/projects/#{@another_project.id}",
        headers: {Authorization:  "Bearer "+ token}
      end
      it "can not update other's project" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end

