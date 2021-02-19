Rails.application.routes.draw do
  root 'home#index'

  devise_for :collaborators, path: 'collaborators', controllers: { registrations: 'collaborators/registrations' }

  devise_for :candidates, path: 'candidates'
  resources :companies
  resources :social_networks
  resources :jobs
end
