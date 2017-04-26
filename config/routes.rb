Rails.application.routes.draw do
  resources :movies do
    collection do
        get 'search'
    end
  end

  resources :users, only: %i[new create]

  root 'movies#index'
end
