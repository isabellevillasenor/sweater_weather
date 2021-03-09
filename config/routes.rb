Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:show]
      get '/backgrounds', to: 'images#show'
      resources :users, only: [:create]
    end
  end
end
