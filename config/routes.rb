# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  authenticate :admin do
    root to: 'pages#home'
    resources :business_types
    resources :businesses do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :businesses, only: %i[show index create]
    resources :donations, only: %i[create]
  end
end
