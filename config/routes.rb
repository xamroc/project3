Project3::Application.routes.draw do

  root 'site#index'

  resources :site

  get  'register' => 'registration#new', as: :register
  post 'register' => 'registration#create'

  get     'login' => 'session#new'
  post    'login' => 'session#create'
  delete 'logout' => 'session#destroy'
  get    'logout' => 'session#destroy' #TODO: remove before deployment

  get     'newtool' => 'tools#new'


  scope :api do
    get '' => "api#index", as: :api, defaults: {format: :json}

    resources :tools, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "tools#show", on: :collection
    end

    resources :users, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "users#show", on: :collection
    end

    resources :transactions, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "transactions#show", on: :collection
    end
  end

end
