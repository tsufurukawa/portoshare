Rails.application.routes.draw do
  root to: 'pages#front'

  resources :projects, only: [:index, :show]
end
