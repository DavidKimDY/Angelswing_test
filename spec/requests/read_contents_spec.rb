require 'rails_helper'

RSpec.describe Content, type: :request do
  describe 'Get /api/v1/projects/:project_id/contents' do
    context 'with valid Authorization' do
     before do
        @user = User.find_by_sql('select * from users limit 1')[0]
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        project = Project.find_by_sql('select * from projects limit 1')[0]
        get "/api/v1/projects/#{project.id}/contents",
        headers: {Authorization:  "Bearer "+ token}
     end 

     it 'shows contents' do
        expect(response).to have_http_status(:success)
     end
    end
    context 'with invalid Authorization' do
     before do
        project = Project.find_by_sql('select * from projects limit 1')[0]
        get "/api/v1/projects/#{project.id}/contents"
     end 

     it 'can not show a content because of unauthorized' do
        expect(response).to have_http_status(:unauthorized)
     end
    end
  end
  describe 'Get /api/v1/projects/:project_id/contents/:content' do
    context 'with valid Authorization' do
     before do
        @user = User.find_by_sql('select * from users limit 1')[0]
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        content = Content.find_by_sql('select * from contents limit 1')[0]
        get "/api/v1/projects/#{content.project_id}/contents/#{content.id}",
        headers: {Authorization:  "Bearer "+ token}
     end 

     it 'shows a specific content' do
        expect(response).to have_http_status(:success)
     end
    end

    context 'with invalid Authorization' do
     before do
        content = Content.find_by_sql('select * from contents limit 1')[0]
        get "/api/v1/projects/#{content.project_id}/contents/#{content.id}"
     end 

     it 'can not show a content because of unauthorized' do
        expect(response).to have_http_status(:unauthorized)
     end
    end
  end
end

