Rails.application.routes.draw do

  #developer apikey application
  root  'start#start'
  get    'login'   => 'login#new'
  post   'login'   => 'login#login'
  get 'logout'  => 'login#logout'
  get 'signup' => 'users#new'
   get :token, controller: 'application'
  resources :users
  resources :apikeys
  
  #api
  namespace :api do
    namespace :v1 do
      get 'birds'   => 'birds#birds'
      get 'birds/:id' => 'birds#bird'
      get 'birdspotters' => 'birdspotters#birdspotters'
      get 'birdspotters/:id' => 'birdspotters#birdspotter'
      get 'spots'   => 'spots#spots'
      get 'spots/:id' => 'spots#spot'
      post 'spots' => 'spots#create'
      delete 'spots/:id' => 'spots#destroy'
      put 'spots/:id' => 'spots#update'
      get 'position/nearby' => 'position#spots_nearby'
     
    end
  end
end
