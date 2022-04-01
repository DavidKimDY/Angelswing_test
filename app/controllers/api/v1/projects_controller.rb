module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorized, only: [:create, :update, :delete, :read_my_projects]
      def create
        project = Project.new(project_params)
        project.user_id = @user.id
        type_to_project_type = {"in_house" =>0, "external" => 1, "international" => 2} 
        project.project_type = type_to_project_type[params[:type]]
        if project.save
          render json: {data: data(project)}, status: :ok
        else
          render json: {error: project.errors}, status: :unprocessable_entity 
        end
      end

      def update
        project = Project.find(params[:id])
        if project.user.id != @user.id
          render json: {error: "Unauthorized"}, status: :unauthorized
        elsif project.update(project_params)
          render json: {data: data(project)}
        else
          render json: {error: project.errors}, status: :unprocessable_entity
        end
      end

      def read
        project = Project.find(params[:id])
        render json: {data: data(project)}
      end

      def read_all
        project_all = Project.all
        render json: {data: data_many(project_all)}
      end

      def read_my_projects
        render json: {data: data_many(@user.projects)}
      end

      def delete
        project = Project.find(params[:id])
        if project.user.id != @user.id
          render json: {error: "Unauthorized"}, status: :unauthorized
        else
          project.destroy
          render json: {message: "Deleted"}
        end
      end

      private
      def data (project)
        project_type_to_type = {0 => "in_house", 1 => "external", 2 => "international"}
        data = {
          id: project.id,
          type: "project",
          attributes: {
            "title": project.title, 
            "thumbnail": project.thumbnail,
            "location": project.location,
            "type" => project_type_to_type[project.project_type], 
            "createdAt": project.created_at,
            "updatedAt": project.updated_at
          }
        }
        return data 
      end
      
      def data_many (project_many)
        data_many = []
        for project in project_many
          data_many.append(data(project))
        end
        return data_many
      end
        

      def project_params
        params.require(:project).permit(:title, :type, :location, :thumbnail, :description)
      end
    end
  end
end
