Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#show'
      get '/backgrounds', to: 'images#show'
      get '/trails', to: 'trails#show'
    end
  end
end
