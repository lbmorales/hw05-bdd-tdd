Rottenpotatoes::Application.routes.draw do
  root :to => redirect('/movies')

  resources :movies do
    match 'find', to: 'movies#find', via: [:get]
  end
  
  # get '/movies/:id/find', to: 'movies#find'
  
  # match '/movies/:id/find', to: 'movies#find', via: [:get]
  # root :to => 'movies#index'
end
