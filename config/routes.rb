Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecast#local_five_day'
      get '/backgrounds', to: 'images#skyline_image'
    end
  end
end
