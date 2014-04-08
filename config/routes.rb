Project3::Application.routes.draw do

  root 'site#index'

  resources :session
  resources :site
  resources :tools

  get 'login' => 'session#new'
  post 'login' => 'session#create'
end
