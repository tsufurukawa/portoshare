Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, only: [:index, :show]

  get '/sign_up', to: 'users#new'
  resources :users, only: [:create]

  get '/log_in', to: 'sessions#new'
  post '/log_in', to: 'sessions#create'
end
