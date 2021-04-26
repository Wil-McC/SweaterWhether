Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#local_five_day'
      get '/backgrounds', to: 'images#skyline_image'
      resources :users, only: [:create]
      post '/sessions', to: 'sessions#login'
    end
  end
end
