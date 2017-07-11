Rottenpotatoes::Application.routes.draw do
  root :to => redirect('/movies')

  resources :movies do
    match 'find', to: 'movies#find', via: [:get]
  end
end
