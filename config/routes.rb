Rails.application.routes.draw do
  root 'home#index'

  devise_for :collaborators, path: 'collaborators', controllers: { registrations: 'collaborators/registrations' }
  resources :collaborators, only: %i[index]

  devise_for :candidates, path: 'candidates'
  resources :candidates, only: %i[index]

  resources :companies
  resources :social_networks
  resources :jobs

  get 'search', to:"home#search"
end
