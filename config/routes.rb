Project3::Application.routes.draw do

  root 'site#index'

  resources :site
  resources :messages

  get   'messages' => 'messages#index'

  get  'register' => 'registration#new', as: :register
  post 'register' => 'registration#create'

  get     'login' => 'session#new'
  post    'login' => 'session#create'
  delete 'logout' => 'session#destroy'
  get    'logout' => 'session#destroy' #TODO: remove before deployment

  get   'edituser' => 'users#edit'
  get    'newtool' => 'tools#new'
  get   'tools/edit/:id' => 'tools#edit', as: :edit
  get 'newtransaction' => 'transactions#new'


  scope :api do
    get '' => "api#index", as: :api, defaults: {format: :json}

    resources :users, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "users#index", on: :collection

        resources :tools, except: [ :edit, :new ], defaults: {format: :json} do
          get ':id' => "tools#index", on: :collection
        end

        resources :transactions, except: [ :edit, :new ], defaults: {format: :json} do
          get ':id' => "transactions#index", on: :collection
        end

    end

    resources :tools, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "tools#index", on: :collection

        resources :transactions, except: [ :edit, :new ], defaults: {format: :json} do
          get ':id' => "transactions#index", on: :collection
        end

    end

    resources :transactions, except: [ :edit, :new ], defaults: {format: :json} do
      get ':id' => "transactions#index", on: :collection
    end
  end

end
