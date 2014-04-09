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

  scope :api do
    get '' => "api#index", as: :api, defaults: {format: :json}

    resources :tools, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "tools#show", on: :collection
    end
  end

end
