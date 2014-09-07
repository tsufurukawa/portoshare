Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, only: [:index, :new, :create, :edit]  do
    get '/details/new', to: 'project_details#new'
    post '/details', to: 'project_details#create'
  end

  get '/sign_up', to: 'users#new'

  resources :users, only: [:show, :create, :edit, :update] do
    resources :projects, only: [:show]
    resources :authorizations, only: [:new]
    resources :project_steps, only: [:index, :show]
    delete '/unlink_github', to: 'authorizations#destroy'
  end


  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'authorizations#create'
  get '/auth/failure', to: 'authorizations#failure'

end