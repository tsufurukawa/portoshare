Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, except: [:destroy] do
    member do
      post :vote, to: "votes#create"
    end
  end
  
  resources :users, only: [:show, :create, :edit, :update] do
    resources :authorizations, only: [:new]
    delete '/unlink_github', to: 'authorizations#destroy'

    get '/password_resets', to: 'password_resets#new'
    post '/password_resets', to: 'password_resets#create'
  end

  get '/sign_up', to: 'users#new'
  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'authorizations#create'
  get '/auth/failure', to: 'authorizations#failure'

  resources :tags, only: [:index]
  get '/tags/:tag', to: 'tags#show', as: :tag
end