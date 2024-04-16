Rails.application.routes.draw do
  resources :user_projects
  devise_for :users, path: '', path_names:{sign_in:'login',sign_out:'logout', sign_up:'register'}
  get 'pages/home'

  # get '/projects', to: 'projects#index'
  #not able to create helper method
  # get '/projects/:id', to: 'projects#show'
  # get '/projects/new', to: 'projects#new'
  
  resources :projects
  resources :bugs

  root "pages#home"
end
