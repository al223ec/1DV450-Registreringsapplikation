Rails.application.routes.draw do
  get 'sessions/new'

  root              'static_pages#home'
  get     'about'   =>  'static_pages#about'
  get     'signup'  =>  'api_users#new'
  get     'login'   =>  'sessions#new'
  post    'login'   =>  'sessions#create'
  delete  'logout'  =>  'sessions#destroy'

  resources :api_users
  resources :applications,          only: [:create, :destroy]

  namespace :api, defaults: { format: :json },
    constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1 do
      # För att denna routing ska fungera kan man inte använda localhost, lvh.me:3000 kan användas ist
      # https://veerasundaravel.wordpress.com/2011/11/13/localhost-alternates-for-subdomain/
      # http://api.lvh.me:3000/events/1

      post 'end_users/login'   =>  'end_users#login'

      resources :end_users, only: [:show, :index, :create] do
          resources :events, only: [:show, :index, :destroy]
      end

      post 'events/query' => 'events#query'
      resources :events

      resources :tags, only: [:show, :index, :create] do
          resources :events, only: [:index, :destroy]
      end

      resources :positions, only:[:show, :index, :create] do
      end
    end
  end
end
