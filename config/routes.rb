Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/users/signup' => 'users#signup'
      post '/auth/signin' => 'users#signin'
      
      post '/projects' => 'projects#create'
      get '/projects/:id' => 'projects#read'
      get '/projects' => 'projects#read_all'
      get '/projects/my_projects' => 'projects#read_my_projects'
      put '/projects/:id' => 'projects#update'
      delete '/projects/:id' => 'projects#delete'

      post '/projects/:project_id/contents' => 'contents#create'
      get '/projects/:project_id/contents/:id' => 'contents#read'
      get '/projects/:project_id/contents' => 'contents#read_all_in_project'
      put '/contents/:id' => 'contents#update'
      delete '/contents/:id' => 'contents#delete'
    end
  end
end
