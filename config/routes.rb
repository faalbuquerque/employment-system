Rails.application.routes.draw do
  root 'home#index'

  devise_for :collaborators, controllers: { registrations: 'collaborators/registrations' }
end
