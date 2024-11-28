Rails.application.routes.draw do
  get 'hello/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get '/hello', to: 'hello#index'
  get '/login', to: 'login#index'
  post '/logout', to: 'login#logout'
  post '/logincheck', to: 'login#check'
  get '/wines', to: 'wines#index'
  get '/winesdisp', to: 'wines#disp'
  get '/winesdisp2', to: 'wines#disp2'
  get '/winesdisp3', to: 'wines#disp3'
  get '/winesdisp4', to: 'wines#disp4'
  get '/winesdisp5', to: 'wines#disp5'
  get '/wineslist', to: 'wines#list'
  get '/winescsv', to: 'wines#csv'
  get '/winesnew', to: 'wines#new'
  post '/winesadd', to: 'wines#add'
  get '/winesclean', to: 'wines#clean'
  post '/winesdel', to: 'wines#del'
  get '/winesqte', to: 'wines#qte'
  post '/winesupdmin', to: 'wines#updmin'
  post '/winesupdmax', to: 'wines#updmax'
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root 'welcome#index'
end
