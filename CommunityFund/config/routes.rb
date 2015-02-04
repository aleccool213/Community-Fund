Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}

  root "home#index"

  #dashboard
  get 'dashboard' => 'dashboard#index'
  get 'dashboard/collect_information' => 'dashboard#collect_information'
  post 'dashboard/submit_information' => 'dashboard#submit_information'

  #communities
  get 'communities' => 'communities#index'

  resources
end
