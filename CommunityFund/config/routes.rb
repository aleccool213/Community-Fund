Rails.application.routes.draw do
  # devise overrides
  devise_for :users, controllers: {registrations: 'registrations'}

  root "home#index"

  #dashboard
  get 'dashboard' => 'dashboard#index'
  get 'dashboard/collect_information' => 'dashboard#collect_information'
  post 'dashboard/submit_information' => 'dashboard#submit_information'
  get 'users/:username' => 'users#show', as: 'users'

  #communities
  get 'communities' => 'communities#index'
  get 'communities/:id/edit_photo' => 'communities#edit_photo'
  post 'communities/:id/join' => 'communities#join'

  namespace :admin do
    get :analytics

    get :settings
    post 'settings/update_admins', to: :update_admins

    get :moderation
  end

  namespace :report do
    post :dismiss
    post :project
  end

  resources :communities
  resources :projects
  resources :funds
  resources :posts
  resources :feedbacks do
    member do
      post :submit
      post :dismiss
    end
  end

end
