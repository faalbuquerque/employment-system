Rails.application.routes.draw do

  root 'home#index'

  devise_for :collaborators, path: 'collaborators', controllers: { registrations: 'collaborators/registrations' }

  devise_for :candidates, path: 'candidates'

  #devise_for :collaborators, controllers: { registrations: 'collaborators/registrations' }
end
