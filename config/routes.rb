Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # namespace :api, path: '', constraints: { subdomain: 'api' } do
    namespace :v1, defaults: { format: :json } do
      resources :attendances,     only: [:update, :create, :show]
      resources :users,           only: [:update, :create, :show]
      resources :authentications, only: [:create]
      resources :locations,       only: [:update, :create, :show]
      resources :location_visits, only: [:create]
      resources :games,           only: [:update, :create, :show] do
        collection do
          get 'upcoming'
          get 'going'
          get 'organizing'
        end        
      end
    end
  # end

  devise_for :users

  root 'welcome#index'
end
