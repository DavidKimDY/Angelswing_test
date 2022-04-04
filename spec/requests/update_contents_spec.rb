require 'rails_helper'

RSpec.describe Content, type: :request do
  describe 'Put /api/v1/contents/:id' do
    context 'with valid paramaters' do
      before do
        @content = Content.find_by_sql('select * from contents limit 1')[0]
        @user = User.find(@content.user_id)
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        put "/api/v1/contents/#{@content.id}", params:{
          content:{
          title: "Updated",
          }
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it 'updates contents' do
        expect(response).to have_http_status(:success)
      end
       
      it 'updates title of content' do
        updated_title = JSON.parse(response.body)['data']['attributes']['title']
        expect(updated_title).to eq('Updated')
      end
    end

    context 'with invalid Authorization' do
      before do
        @user, @another_user = User.find_by_sql('select * from users limit 2')
        token = JWT.encode({user_id: @user.id}, ENV["JWT_SECRET"])
        @another_content = Content.find_by({"user_id": @another_user.id})
        put "/api/v1/contents/#{@another_content.id}", params:{
          content:{
          title: "Updated",
          }
        }, 
        headers: {Authorization:  "Bearer "+ token}
      end

      it "can not create contents into other's project" do
        expect(response).to have_http_status(:unauthorized)
      end
    end 
  end
end

