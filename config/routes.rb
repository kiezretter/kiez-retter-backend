# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations]
  authenticate :admin do
    root to: 'businesses#index'
    get '/check_dead_links', to: 'dead_links#check_dead_links'
    get '/check_duplicates', to: 'businesses#check_duplicates'
    resources :business_types
    resources :dead_links, only: %i[index destroy]
    resources :businesses do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :business_imports, except: %i[edit update] do
      member do
        delete :destroy_businesses
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :businesses, only: %i[show index create]
    resources :donations, only: %i[create]
    resources :trackings, only: %i[create]
  end
end
