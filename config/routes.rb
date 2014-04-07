Project3::Application.routes.draw do

  root 'site#index'

  resources :session
  resources :site


end
