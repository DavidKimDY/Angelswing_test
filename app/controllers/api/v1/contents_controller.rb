module Api
  module V1
    class ContentsController < ApplicationController
      before_action :authorized
      def create
        project = Project.find(params[:project_id])
        content = Content.new(content_params)
        content.update(project_id: project.id, user_id: @user.id)
        if project.user.id != @user.id
          render json: {error: "Unauthorized"}, status: :unauthorized
        elsif content.save
          render json: {data: data(content)}, status: :ok
        else
          render json: {error: content.errors}, status: :unprocessable_entity 
        end
      end

      def update
        content = Content.find(params[:id])
        if content.user.id != @user.id
          render json: {error: "Unauthorized"}, status: :unauthorized
        elsif content.update(content_params)
          render json: {data: data(content)}
        else
          render json: {error: content.errors}, status: :unprocessable_entity
        end
      end

      def read
        # GET Specific Content
        project = Project.find(params[:project_id])
        content = project.contents.find(params[:id])
        render json: {data: data(content)}
      end
      
      def read_all_in_project
        # Get Contents
        project = Project.find(params[:project_id])
        content_all = project.contents
        render json: {data: data_many(content_all)}
      end

      def delete
        content = Content.find(params[:id])
        if content.user.id != @user.id
          render json: {error: "Unauthorized"}, status: :unauthorized
        else
          content.destroy
          render json: {message: "Deleted"}
        end
      end

      private
      def content_params
        params.require(:content).permit(:title, :body)
      end
      
      def data (content)
        data = {
          id: content.id,
          type: "content",
          attributes: {
            "projectId": content.project.id,
            "projectOwnerName": content.project.user.first_name + " " + content.project.user.last_name,
            "title": content.title, 
            "body": content.body,
            "createdAt": content.created_at,
            "updatedAt": content.updated_at
          }
        }
        return data
      end
    
      def data_many (content_many)
        data_many = []
        for content in content_many
          data_many.append(data(content))
        end
        return data_many
      end
    end
  end
end
