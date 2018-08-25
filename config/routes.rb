Rails.application.routes.draw do
  resources :dogs
  root 'home#index'
end
