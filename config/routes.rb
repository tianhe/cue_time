Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # namespace :api, path: '', constraints: { subdomain: 'api' } do
    namespace :v1, defaults: { format: :json } do
      resources :attendances,     only: [:create, :index, :update, :show, :destroy]
      resources :users,           only: [:update, :show]
      resources :authentications, only: [:create]
      resources :locations,       only: [:create, :update, :show]
      resources :location_visits, only: [:create]
      resources :activities,      only: [:create, :index]
      
      resources :user_activities, only: [:create, :index]
      delete 'user_activities',   to: 'user_activities#destroy'

      resources :games,           only: [:create, :update, :show, :destroy] do
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
