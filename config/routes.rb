Rails.application.routes.draw do
  resources :flexiloads, except: [:edit, :update, :destroy]
  root 'flexiloads#index'
end
