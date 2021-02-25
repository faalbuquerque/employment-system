Rails.application.routes.draw do
  root 'home#index'

  devise_for :collaborators, path: 'collaborators', controllers: { registrations: 'collaborators/registrations' }
  resources :collaborators, only: %i[index]

  devise_for :candidates, path: 'candidates'
  resources :candidates, only: %i[index]

  resources :companies, only: %i[edit update show destroy]
  resources :social_networks, except: %i[index]
  resources :jobs, except: %i[index]

  get 'search', to:"home#search"

  resources :applications, except: %i[new]
end
