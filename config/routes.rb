Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

    root :to => 'users#show'

    resources :users

    get '/login' => 'session#new', :as => 'login'
    post '/login' =>  'session#create'
    delete '/login' => 'session#destroy'

    resources :portfolios

    resources :transactions, :only => ["new", 'create', 'index']

end
