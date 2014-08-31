Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, only: [:index, :show]

  get '/sign_up', to: 'users#new'
  resources :users, only: [:show, :create] do
    resources :projects, only: [:show]
  end

  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
  delete '/log_out', to: 'sessions#destroy'
end