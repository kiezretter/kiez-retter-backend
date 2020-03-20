# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  authenticate :admin do
    root to: 'businesses#index'
    resources :businesses do
      member do
        patch :approve
        patch :reject
      end
    end
  end

  namespace 'api', defaults: { format: :json } do
    resources :businesses, only: %i[show index create]
  end
end
