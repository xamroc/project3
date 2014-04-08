Project3::Application.routes.draw do

  root 'site#index'

  resources :site
  resources :tools

  get  'register' => 'registration#new', as: :register
  post 'register' => 'registration#create'

  get     'login' => 'session#new'
  post    'login' => 'session#create'
  delete 'logout' => 'session#destroy'
  get    'logout' => 'session#destroy' #TODO: remove before deployment
end
