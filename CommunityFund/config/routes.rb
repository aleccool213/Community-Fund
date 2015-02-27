Rails.application.routes.draw do
  # devise overrides
  devise_for :users, controllers: {registrations: 'registrations'}

    root "home#index"

  #dashboard
  get 'dashboard' => 'dashboard#index'
  get 'dashboard/collect_information' => 'dashboard#collect_information'
  post 'dashboard/submit_information' => 'dashboard#submit_information'

  #communities
  get 'communities' => 'communities#index'

  namespace :admin do
    get :analytics
    get :settings
    post 'settings/update_admins', to: :update_admins
  end

  resources :communities
  resources :projects
  resources :funds
  resources :feedbacks do
    member do
      post :submit
      post :dismiss
    end
  end
end
