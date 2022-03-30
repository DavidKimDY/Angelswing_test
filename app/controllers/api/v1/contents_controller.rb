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
          render json: {status: "Success"}
        end

        def read
          render json: {status: "Success"}
        end
        
        def read_all_in_project
          render json: {status: "Success"}
        end

        def delete
          render json: {status: "Success"}
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

      end
  end
end
