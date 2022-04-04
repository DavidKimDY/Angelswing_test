require 'rails_helper'

RSpec.describe Project, type: :request do
  describe 'Post /api/v1/projects' do
     before do
        project = Project.find_by_sql('select * from projects limit 1')[0]
        get "/api/v1/projects/#{project.id}"
     end 

     it 'shows a project without authentication' do
        expect(response).to have_http_status(:success)
     end
     
     before do
        get "/api/v1/projects/"
     end 

     it 'shows all project without authentication' do
        expect(response).to have_http_status(:success)
     end
     
     before do
        @user = User.find_by_sql('select * from users limit 1')[0]
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        get "/api/v1/projects/my_projects",
        headers: {Authorization:  "Bearer "+ token}
     end 

     it 'shows my project' do
        expect(response).to have_http_status(:success)
     end
  end
end

