module Api
  module V1
    class ContentsController < ApplicationController
      def create
        project = Project.find(params[:project_id])
        content = Content.new(content_params)
        content.update(project_id: project.id, user_id: project.user.id)
        if content.save
          render json: {data: data(content)}, status: :ok
        else
          render json: {data: content.errors}, status: :unprocessable_entity 
        end
      end

      def update
        content = Content.find(params[:id])
        if content.update(content_params)
          render json: {data: data(content)}
        else
          render json: {data: content.errors}, status: :unprocessable_entity
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
        content.destroy
        render json: {message: "Deleted"}
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
            "projectOwnerName": content.project.user.last_name + content.project.user.first_name,
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
