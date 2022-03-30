module Api
  module V1
    class ProjectsController < ApplicationController
        def create
        end

        def update
        end

        def read
            project = Project.find(params[:id])
            render json: {data: data(project)}
        end

        def read_all
            render json: {status: "success"}
        end

        def read_my_projects
            render json: {status: "success"}
        end

        def delete
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
      end
  end
end