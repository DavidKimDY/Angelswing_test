Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/users/signup'
      post '/users/signin'

      post '/projects/:id'
      get '/projects/:id'
      put '/projects/:id'
      del '/projects/:id'
      get '/projects'
      get '/projects/my_projects'

      post '/projects/:project_id/contents'
      get '/projects/:project_id/contents'
      put '/projects/:project_id/contents'
      get '/projects/:project_id/contents/:id'
      del '/contents/:id'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
