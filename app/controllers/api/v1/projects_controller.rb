module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :authorized, only: [:create, :update, :delete, :read_my_projects]
      def create
        project = Project.new(project_params)
        if project.save
          render json: {data: data(project)}, status: :ok
        else
          render json: {data: project.errors}, status: :unprocessable_entity 
        end
      end

      def update
        project = Project.find(params[:id])
        if project.update(project_params)
          render json: {data: data(project)}
        else
          render json: {data: project.errors}, status: :unprocessable_entity
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
      end

      def delete
        project = Project.find(params[:id])
        project.destroy
        render json: {message: "Deleted"}
      end

      private
      def data (project)
        data = {
          id: project.id,
          type: "project",
          attributes: project.attributes.except('id')
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
        params.require(:project).permit(:title, :project_type, :location, :thumbnail, :user_id, :description)
      end

      end
  end
end
